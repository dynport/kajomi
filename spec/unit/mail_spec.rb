require "spec_helper"

describe Mail::Message do
  describe "#to_kajomi_hash" do
    let(:message) do
      Mail.new do
        from "sending@dynport.de"
        to "recipient@dynport.de"
        cc "cc_recipient@dynport.de"
        subject "My Kajomi Message"
        body "Hello from Kajomi!"
      end
    end

    subject { message.to_kajomi_hash }

    describe "a simple message" do
      it { should == {
        "sender" => "sending@dynport.de",
        "_m" => [{
          "address" => "recipient@dynport.de",
          "type" => "TO"
        }, {
          "address" => "cc_recipient@dynport.de",
          "type" => "CC"
        }].to_json,
        "m" => {
          "_custom_header" => [],
          "content" => "Hello from Kajomi!",
          "htcontent" => nil,
          "description" => "",
          "fattach" => "",
          "replyto" => nil,
          "senderemail" => "",
          "sendername" => "",
          "subject" => "My Kajomi Message"
        }.to_json
      }}
    end
  end
end
