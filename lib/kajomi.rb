require "multi_json"
require "kajomi/version"
require "kajomi/http_client"
require "kajomi/api_client"
require "kajomi/message_extensions/mail"
require "kajomi/handlers/mail"

module Kajomi
  attr_accessor :shared_key,
    :secret_key,
    :secure,
    :host,
    :path_prefix,
    :http_open_timeout,
    :http_read_timeout

  class DeliveryError < StandardError
    attr_accessor :code, :response

    def initialize(message=nil, code=nil, response=nil)
      super(message)
      @code = code
      @response = response
    end
  end

  class UnknownError < DeliveryError; end
  class AuthorizationError < DeliveryError; end

  def deliver_message(*args)
    api_client.deliver_message(*args)
  end
  alias_method :send_through_kajomi, :deliver_message

  def api_client
    build_api_client
  end

  def build_api_client
    Kajomi::ApiClient.new(self.shared_key, self.secret_key, {
      secure: self.secure,
      host: self.host,
      path_prefix: self.path_prefix,
      http_open_timeout: self.http_open_timeout,
      http_read_timeout: self.http_read_timeout
    })
  end
end
