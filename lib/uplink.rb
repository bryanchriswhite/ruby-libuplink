module LibUplink
  class Uplink < Errable
    attr_reader :ref

    C_ANALOGUE = ::LibUplink::Ext::Storj::UplinkRef

    def initialize(options_path: "", **options)
      if !options_path.empty? && File.exists?(options_path)
        options = ::LibUplink.load_yaml_options(options_path).merge options
      end

      uplink_opts = options[:uplink].nil? ? {} : options[:uplink]
      uplink_cfg = ::LibUplink::Ext::Storj::UplinkConfig.new(uplink_opts)

      # NB: `new_err` initializes `@err`
      @ref = ::LibUplink::Ext::Storj.new_uplink(uplink_cfg, new_err)
      check_err

      # NB: close uplink when instance is garbage collected
      ObjectSpace.define_finalizer(self, proc {::Libuplink::Ext::Storj.close_uplink @ref})
    end

    def open_project(satellite_addr, api_key)
      Project.new(@ref, satellite_addr, api_key)
    end
  end

end
