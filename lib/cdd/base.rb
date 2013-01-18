module CDD
  class Base
    attr_accessor :id
    attr_accessor :name
    attr_accessor :client

    def initialize(client, options={})
      self.client = client
      options.each do |k,v|
        self.send("#{k}=",v)
      end
    end
  end
end