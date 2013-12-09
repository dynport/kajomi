module Mail
  class Kajomi
    attr_accessor :settings

    def initialize(values)
      self.settings = {
        user: nil,
        api_key: nil
      }.merge(values)
    end

    def deliver!(mail)
      settings = self.settings.dup
      user = settings.delete(:user)
      api_key = settings.delete(:api_key)
      api_client = ::Kajomi::ApiClient.new(user, api_key, settings)
      response = api_client.deliver_message(mail)
      self
    end
  end
end
