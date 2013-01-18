module CDD
  class Vault < Base
    attr_accessor :name

    def projects
      client.execute(projects_url).collect do |hash|
        CDD::Project.new(self.client, {:vault => self}.merge(hash))
      end
    end

    def projects_url
      "/api/v1/vaults/#{self.id}/projects"
    end

    def searches
      client.execute(searches_url).collect do |hash|
        CDD::Search.new(client, {:vault => self}.merge(hash))
      end
    end

    def searches_url
      "/api/v1/vaults/#{self.id}/searches"
    end

    def export_url(format="csv")
      "/api/v1/vaults/#{self.id}/exports.#{format}"
    end
  end
end