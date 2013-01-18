module CDD
  class Project < Base
    attr_accessor :name
    attr_accessor :vault

    def projects
      client.execute(projects_url)
    end

    def projects_url
      "/api/v1/vaults/#{self.id}/projects"
    end
  end
end