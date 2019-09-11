module LibUplink
  module Ext
    module Storj
      # TODO: fix?
      # class UplinkConfigTLS < FFI::Struct
      #   def initialize(skip_peer_ca_whitelist:)
      #     self[:skip_peer_ca_whitelist] = skip_peer_ca_whitelist
      #   end
      # end
      #
      # class UplinkConfigVolatile < FFI::Struct
      #   def initialize(skip_peer_ca_whitelist:)
      #     self[:tls] = ::LibUplink::Ext::Storj::UplinkConfigTLS
      #                      .new(skip_peer_ca_whitelist: skip_peer_ca_whitelist)
      #   end
      # end
      #
      # class UplinkConfig < FFI::Struct
      #   def initialize(skip_peer_ca_whitelist:)
      #     self[:volatile] = ::LibUplink::Ext::Storj::UplinkConfigVolatile
      #                           .new(skip_peer_ca_whitelist: skip_peer_ca_whitelist)
      #   end
      # end
    end
  end
end