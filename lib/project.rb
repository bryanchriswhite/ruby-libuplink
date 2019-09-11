module LibUplink
  class Project < Errable
    attr_reader :ref

    C_ANALOGUE = ::LibUplink::Ext::Storj::ProjectRef

    def initialize(uplink_ref, satellite_addr, api_key)
      unless api_key.is_a?(LibUplink::APIKey)
        api_key = LibUplink::APIKey.new(api_key)
      end

      # NB: `new_err` initializes `@err`
      @ref = Ext::Storj.open_project(uplink_ref, satellite_addr, api_key.ref, new_err)
      check_err

      # NB: close uplink when instance is garbage collected
      ObjectSpace.define_finalizer(self, proc {Ext::Storj.close_project @ref})
    end

    def create_bucket(name, config)
      Bucket.create(@ref, name, config)
    end

    def open_bucket(name, encryption_access)
      Bucket.open(@ref, name, encryption_access)
    end
  end
end
