module CDD
  class Project
    attr_accessor :id
    attr_accessor :name
    attr_accessor :client

    def initialize(client, options={})
      self.client = client
      options.each do |k,v|
        self.send("#{k}=",v)
      end
    end

    def projects
      client.execute(projects_url)
    end

    def projects_url
      "/api/v1/vaults/#{self.id}/projects"
    end
  end
end