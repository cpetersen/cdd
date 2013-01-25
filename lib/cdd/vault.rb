module CDD
  class Vault < Base
    attr_accessor :name

    def data_sets
      @data_sets ||= client.execute(data_sets_url).collect do |hash|
        CDD::DataSet.new(self.client, {:vault => self}.merge(hash))
      end
    end

    def data_sets_url
      "/api/v1/vaults/#{self.id}/data_sets"
    end

    def projects
      @project ||= client.execute(projects_url).collect do |hash|
        CDD::Project.new(self.client, {:vault => self}.merge(hash))
      end
    end

    def projects_url
      "/api/v1/vaults/#{self.id}/projects"
    end

    def searches
      @searches ||= client.execute(searches_url).collect do |hash|
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