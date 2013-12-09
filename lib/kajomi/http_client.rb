require "net/http"
require "net/https"
require "cgi"

module Kajomi
  class HttpClient
    attr_reader :http,
      :secure,
      :host,
      :path_prefix,
      :http_open_timeout,
      :http_read_timeout

    attr_accessor :headers

    DEFAULTS = {
      host: "api.kajomimail.de",
      secure: false,
      path_prefix: "/srv/",
      http_read_timeout: 15,
      http_open_timeout: 5
    }

    def initialize(options = {})
      apply_options(options)
      @headers = {}
      @http = build_http
    end

    def post(path, data={})
      perform_request do |client|
        request = Net::HTTP::Post.new(url_path(path), headers)
        request.set_form_data(data)
        client.request(request)
      end
    end

    def add_header(name, value)
      @headers[name] = value
    end

  protected
    def apply_options(options = {})
      options = Hash[*options.select { |_, v| !v.nil? }.flatten]
      DEFAULTS.merge(options).each_pair do |name, value|
        instance_variable_set(:"@#{name}", value)
      end
    end

    def perform_request
      handle_response(yield(http))
    end

    def to_query_string(hash)
      return "" if hash.empty?
      "?" + hash.map { |key, value| "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}" }.join("&")
    end

    def protocol
      self.secure ? "https" : "http"
    end

    def url
      URI.parse("#{protocol}://#{host}/")
    end

    def handle_response(response)
      case response.code.to_i
      when 200
        return response.body
      when 401
        raise error(::Kajomi::AuthorizationError, response)
      else
        raise error(::Kajomi::UnknownError, response)
      end
    end

    def url_path(path)
      path_prefix + path
    end

    def build_http
      http = Net::HTTP.new(url.host, url.port)
      http.read_timeout = self.http_read_timeout
      http.open_timeout = self.http_open_timeout
      http.use_ssl = !!self.secure
      http
    end

    def error(klass, response)
      code, message = code_and_message_from_response(response)
      klass.send(:new, message, code, response)
    end

    def code_and_message_from_response(response)
      body = JSON.parse(response.body)
      [body["code"], body["msg"]]
    end
  end
end
