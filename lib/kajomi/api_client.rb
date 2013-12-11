require "kajomi/http_client"
require "digest/sha1"
require "base64"

module Kajomi
  class ApiClient
    attr_reader :shared_key, :secret_key, :options

    def initialize(shared_key, secret_key, options={})
      @shared_key = shared_key
      @secret_key = secret_key
      @options = options
    end

    def deliver_message(message)
      message_data = message.to_kajomi_hash
      http_client = build_http_client
      http_client.add_header("sessid", generate_session_id)
      http_client.post("api/json/basic/mailrelay/relay", message_data)
    end

  protected
    def build_http_client
      HttpClient.new(options)
    end

    def generate_session_id
      Base64.encode64(Digest::SHA1.digest("#{secret_key}#{random_secret}")).chop
    end

    def random_secret
      http_client = build_http_client
      response = http_client.get("auth/#{shared_key}")
    end
  end
end
