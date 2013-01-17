require "rest_client"
require "json"

module CDD
  class Client
    attr_accessor :token
    attr_accessor :url

    def initialize(token, options={})
      self.token = token
      self.url = options[:url] || "https://app.collaborativedrug.com"
    end

    def vaults
      execute(vaults_url)
    end

    def vaults_url
      "#{self.url}/api/v1/vaults"
    end

    def projects_url(vault_id)
      "#{self.url}/api/v1/vaults/#{vault_id}/projects"
    end

    def execute(url, params={})
      response = RestClient.get url, { :params => params, "X-CDD-Token" => token }
      JSON.parse(response.to_s)
    end
  end
end