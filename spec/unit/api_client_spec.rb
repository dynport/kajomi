require "spec_helper"

describe Kajomi::ApiClient do
  let(:user) { "dynport" }
  let(:api_key) { "API_TEST_KEY" }
  let(:options) { {} }

  let(:api_client) { Kajomi::ApiClient.new(user, api_key, options) }

  describe "#generate_session_id", :vcr do
    subject { api_client.send(:generate_session_id) }

    it { should be_a String }
    its(:length) { should > 0 }
  end
end
