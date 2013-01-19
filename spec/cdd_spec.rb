require 'cdd'

describe CDD do

  def fake_response(body)
    net_http_resp = Net::HTTPResponse.new(1.0, 200, "OK")
    # net_http_resp.add_field 'Set-Cookie', 'Monster'
    RestClient::Response.create(body, net_http_resp, nil)
  end

  context "A default client" do
    context "when requesting vaults" do
      let(:token) { ENV["CDD_TOKEN_ID"] || "1234567890" }
      let(:client) { CDD::Client.new(token) }

      it "should have the correct vaults_url" do
        client.vaults_url.should == "/api/v1/vaults"
      end

      it "should call the default vaults url" do
        RestClient.should_receive(:get).with("https://app.collaborativedrug.com/api/v1/vaults", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "1234", :name => "Test Vault"}].to_json))
        client.vaults
      end

      context "when requesting vaults" do
        before(:all) do
          RestClient.stub(:get).with("https://app.collaborativedrug.com/api/v1/vaults", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "1234", :name => "Test Vault"}].to_json))
        end
        let(:vaults) { client.vaults }

        it "should return an array of vaults" do
          vaults.class.should == Array
          vaults.first.class.should == CDD::Vault
        end

        context "the vault" do
          let(:vault) { vaults.first }

          it "should have the correct values" do
            vault.id.should == "1234"
            vault.name.should == "Test Vault"
          end

          it "should have the correct default export_url" do
            vault.export_url.should == "/api/v1/vaults/#{vault.id}/exports.csv"
          end

          it "should have the correct csv export_url" do
            vault.export_url("csv").should == "/api/v1/vaults/#{vault.id}/exports.csv"
          end

          it "should have the correct sdf export_url" do
            vault.export_url("sdf").should == "/api/v1/vaults/#{vault.id}/exports.sdf"
          end

          it "should have the correct searches_url" do
            vault.searches_url.should == "/api/v1/vaults/#{vault.id}/searches"
          end

          it "should call the default searches url" do
            RestClient.should_receive(:get).with("https://app.collaborativedrug.com/api/v1/vaults/#{vault.id}/searches", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "12345", :name => "Test Search"}].to_json))
            vault.searches
          end

          context "when requesting searches" do
            before(:all) do
              RestClient.stub(:get).with("https://app.collaborativedrug.com/api/v1/vaults/#{vault.id}/searches", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "12345", :name => "Test Search"}].to_json))
            end
            let(:searches) { vault.searches }

            it "should return an array of searches" do
              searches.class.should == Array
              searches.first.class.should == CDD::Search
            end

            context "the search" do
              let(:search) { searches.first }

              it "should have the correct values" do
                search.id.should == "12345"
                search.name.should == "Test Search"
              end
            end
          end

          it "should have the correct projects_url" do
            vaults.first.projects_url.should == "/api/v1/vaults/#{vaults.first.id}/projects"
          end

          it "should call the default projects url" do
            RestClient.should_receive(:get).with("https://app.collaborativedrug.com/api/v1/vaults/#{vaults.first.id}/projects", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "123456", :name => "Test Project"}].to_json))
            vault.projects
          end

          context "when requesting projects" do
            before(:all) do
              RestClient.stub(:get).with("https://app.collaborativedrug.com/api/v1/vaults/#{vaults.first.id}/projects", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "123456", :name => "Test Project"}].to_json))
            end
            let(:projects) { vault.projects }

            it "should return an array of projects" do
              projects.class.should == Array
              projects.first.class.should == CDD::Project
            end

            context "the project" do
              let(:project) { projects.first }

              it "should have the correct values" do
                project.id.should == "123456"
                project.name.should == "Test Project"
              end
            end
          end
        end
      end
    end
  end

  context "A client with a custom url" do
    context "when requesting vaults" do
      let(:token) { ENV["CDD_TOKEN_ID"] || "1234567890" }
      let(:client) { CDD::Client.new(token, :url => "http://example.com") }

      it "should call the custom vaults url" do
        RestClient.should_receive(:get).with("http://example.com/api/v1/vaults", { :params=>{} , "X-CDD-Token" => token}).and_return(fake_response([{:id => "1234", :name => "Test Vault"}].to_json))
        vaults = client.vaults
      end
    end
  end
end
