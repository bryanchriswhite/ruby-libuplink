module LibUplink
  module Ext
    module LibC
      extend FFI::Library
      ffi_lib('c')

      attach_function('fopen', [:string, :string], :pointer)
      attach_function('fclose', [:pointer], :int)
    end

    module Storj
      extend FFI::Library
      # TODO: cleanup
      LIBUPLINK_PATH = File.join __dir__, '..', '..', 'ext', 'storj', 'uplink.so'

      ffi_lib(LIBUPLINK_PATH)

      attach_function('new_uplink', 'new_uplink', [
          UplinkConfig,
          :pointer # error string double pointer
      ], UplinkRef.by_value)

      attach_function('open_project', 'open_project', [
          UplinkRef,
          :string, # satellite_addr
          :string, # api_key
          :pointer # error string double pointer
      ], ProjectRef.by_value)

      attach_function('create_bucket', 'create_bucket', [
          ProjectRef,
          :string, # bucket name
          BucketConfig,
          :pointer # error string double pointer
      ], BucketInfo.by_value)
    end
  end
end
