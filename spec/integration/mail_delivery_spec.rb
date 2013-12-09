require "spec_helper"

describe "Mail delivery" do
  let(:api_client) { double("api client") }
  let(:response) { double("response") }
  let(:message) {
    Mail.new do
      from "sender@dynport.de"
      to "recipient@dynport.de"
      subject "My Subject"
      body "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
           "eiusmod tempor incididunt ut labore et dolore magna aliqua."

      delivery_method Mail::Kajomi, api_key: "KAJOMI_API_TEST_KEY", user: "dynport"
    end
  }

  describe "simple email delivery" do
    it "should send the mail via the kajomi api client" do
      Kajomi::ApiClient.stub(:new).with("dynport", "KAJOMI_API_TEST_KEY", kind_of(Hash)).and_return(api_client)
      api_client.should_receive(:deliver_message).with(message).and_return(response)
      return_value = message.deliver
      return_value.should eql message
    end
  end
end
