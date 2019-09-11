module LibUplink
  class APIKey < Errable
    attr_reader :ref

    C_ANALOGUE = ::LibUplink::Ext::Storj::APIKeyRef

    def initialize(api_key_str)
      @ref = ::LibUplink::Ext::Storj.parse_api_key(api_key_str, new_err)
      check_err

      # NB: close uplink when instance is garbage collected
      ObjectSpace.define_finalizer(self, proc {Ext::Storj.free_api_key @ref})
    end
  end
end