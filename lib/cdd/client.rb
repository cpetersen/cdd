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
      @vaults ||= execute(vaults_uri).collect do |hash|
        CDD::Vault.new(self,hash)
      end
    end

    def vaults_uri
      "/api/v1/vaults"
    end

    def execute(uri, params={})
      response = RestClient.get "#{self.url}#{uri}", { :params => params, "X-CDD-Token" => token }
      JSON.parse(response.to_s)
    end
  end
end