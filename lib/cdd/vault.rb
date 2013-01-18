module CDD
  class Vault < Base
    def projects
      client.execute(projects_url).collect do |hash|
        CDD::Project.new(self.client, hash)
      end
    end

    def projects_url
      "/api/v1/vaults/#{self.id}/projects"
    end

    def searches
      client.execute(projects_url).collect do |hash|
        CDD::Search.new(self.client, hash)
      end
    end

    def searches_url
      "/api/v1/vaults/#{self.id}/searches"
    end
  end
end