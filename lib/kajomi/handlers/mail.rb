module Mail
  class Kajomi
    attr_accessor :settings

    def initialize(values)
      self.settings = {
        shared_key: nil,
        secret_key: nil,
        return_response: false
      }.merge(values)
    end

    def deliver!(mail)
      settings = self.settings.dup
      shared_key = settings.delete(:shared_key)
      secret_key = settings.delete(:secret_key)
      api_client = ::Kajomi::ApiClient.new(shared_key, secret_key, settings)
      response = api_client.deliver_message(mail)

      if settings[:return_response]
        response
      else
        self
      end
    end
  end
end
