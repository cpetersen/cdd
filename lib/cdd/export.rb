module CDD
  class Export < Base
    attr_accessor :format
    attr_accessor :status
    attr_accessor :search
    attr_accessor :vault

    def poll
      client.execute(poll_url)
    end

    def poll_url
      "/api/v1/vaults/#{vault.id}/export_progress/#{self.id}"
    end

    def data
      response = RestClient.get "#{client.url}#{data_url}", { :params => {}, "X-CDD-Token" => client.token }
      response.to_s if response
    end

    def data_url
      "/api/v1/vaults/#{vault.id}/exports/#{id}"
    end
  end
end