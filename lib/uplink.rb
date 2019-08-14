module LibUplink
  class Errable
    private

    def new_err_double_ptr
      @err = FFI::MemoryPointer.new(:pointer)
      @err.write_pointer FFI::MemoryPointer.from_string("")
    end

    def check_err
      err_msg = @err.read_pointer.read_string
      unless err_msg == ''
        throw :libuplink_error, err_msg
      end
    end
  end

  class Uplink < Errable
    attr_reader :ref

    C_ANALOGUE = ::LibUplink::Ext::Storj::UplinkRef

    def initialize(options_path: "", **options)
      if !options_path.empty? && File.exists?(options_path)
        options = ::LibUplink.load_yaml_options(options_path).merge options
      end

      @err = new_err_double_ptr
      uplink_cfg = ::LibUplink::Ext::Storj::UplinkConfig.new(**options[:uplink_config])
      @ref = ::LibUplink::Ext::Storj.new_uplink(uplink_cfg, @err)

      check_err

      # NB: close uplink when instance is garbage collected
      ObjectSpace.define_finalizer(self, proc {::Libuplink::Ext::Storj.close_uplink @ref})
    end

    def open_project(satellite_addr, api_key)
      Project.new ::LibUplink::Ext::Storj.open_project(@ref, satellite_addr, api_key, @err)
    end
  end

  class Project < Errable
    attr_reader :ref

    C_ANALOGUE = ::LibUplink::Ext::Storj::ProjectRef

    def initialize(project_ref)
      @ref = project_ref
    end
  end
end
