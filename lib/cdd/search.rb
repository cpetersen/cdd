module CDD
  class Search < Base
    attr_accessor :name
    attr_accessor :vault

    def start_export(projects=[], data_sets=[], format="csv")
      project_ids = projects.collect { |p| p.id }
      data_set_ids = data_sets.collect { |ds| ds.id }
      params = { :search => self.id, :projects => project_ids.join(","), :data_sets => data_set_ids.join(",") }
      result = JSON.parse(RestClient.post("#{client.url}#{vault.export_url(format)}", params, { "X-CDD-Token" => client.token }))
      CDD::Export.new(client, { :search => self, :vault => vault, :format => format }.merge(result))
    end

    def export(projects=[], data_sets=[], format="csv", &block)
      e = start_export(projects, data_sets, format)
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