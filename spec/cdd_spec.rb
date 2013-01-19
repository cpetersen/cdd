require 'cdd'

describe CDD do

  def fake_response(body)
    net_http_resp = Net::HTTPResponse.new(1.0, 200, "OK")
    # net_http_resp.add_field 'Set-Cookie', 'Monster'
    RestClient::Response.create(body, net_http_resp, nil)
  end

  context "A default client" do
    let(:token) { ENV["CDD_TOKEN_ID"] || "1234567890" }
    let(:client) { CDD::Client.new(token) }

    it "should have the correct vaults_url" do
      client.vaults_url.should == "/api/v1/vaults"
    end

    it "should call the default url" do
      RestClient.should_receive(:get).with("https://app.collaborativedrug.com/api/v1/vaults", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "1234", :name => "Test Vault"}].to_json))
      vaults = client.vaults
    end
  end

  context "A client with a custom url" do
    let(:token) { ENV["CDD_TOKEN_ID"] || "1234567890" }
    let(:client) { CDD::Client.new(token, :url => "http://example.com") }

    it "should call the custom url" do
      RestClient.should_receive(:get).with("http://example.com/api/v1/vaults", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "1234", :name => "Test Vault"}].to_json))
      vaults = client.vaults
    end
  end
end
