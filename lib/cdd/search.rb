module CDD
  class Search < Base
    attr_accessor :name
    attr_accessor :vault

    def start_export(projects=[], format="csv")
      project_ids = projects.collect { |p| p.id }
      params = { :search => self.id, :projects => project_ids }
      result = JSON.parse(RestClient.post("#{client.url}#{vault.export_url(format)}", params, { "X-CDD-Token" => client.token }))
      CDD::Export.new(client, { :search => self, :vault => vault, :format => format }.merge(result))
    end

    def export(projects=[], format="csv", &block)
      e = start_export(projects, format)
      state = e.poll
      while ["new", "started", "starting"].include?(state["status"]) do
        state = e.poll
      end
      data = e.data
      if block
        return block.call(data)
      else
        return data
      end
    end
  end
end