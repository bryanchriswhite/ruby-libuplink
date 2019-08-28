module LibUplink
  class Project < Errable
    attr_reader :ref

    C_ANALOGUE = ::LibUplink::Ext::Storj::ProjectRef

    def initialize(project_ref)
      new_err

      @ref = project_ref

      # NB: close uplink when instance is garbage collected
      ObjectSpace.define_finalizer(self, proc {Libuplink::Ext::Storj.close_project @ref})
    end

    def create_bucket(name, config)
      bucket_info = ::LibUplink::Ext::Storj::create_bucket(@ref, name, config, @err)
      check_err
    end
  end
end
