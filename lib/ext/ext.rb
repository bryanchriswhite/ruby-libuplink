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

      attach_function('parse_api_key', 'parse_api_key', [
          :string, # serialized apikey
          :pointer # error string double pointer
      ], APIKeyRef.by_value)

      attach_function('serialize_api_key', 'serialize_api_key', [
          APIKeyRef.by_value,
          :pointer # error string double pointer
      ], :string)

      attach_function('free_api_key', 'free_api_key', [
          APIKeyRef.by_value,
      ], :void)

      attach_function('new_uplink', 'new_uplink', [
          UplinkConfig.by_value,
          :pointer # error string double pointer
      ], UplinkRef.by_value)

      attach_function('open_project', 'open_project', [
          UplinkRef.by_value,
          :string, # satellite_addr
          APIKeyRef.by_value,
          :pointer # error string double pointer
      ], ProjectRef.by_value)

      attach_function('create_bucket', 'create_bucket', [
          ProjectRef.by_value,
          :string, # bucket name
          BucketConfig.by_value,
          :pointer # error string double pointer
      ], BucketInfo.by_value)

      attach_function('create_bucket', 'create_bucket', [
          ProjectRef.by_value,
          :string, # bucket name
          BucketConfig.by_ref,
          :pointer # error string double pointer
      ], BucketInfo.by_value)

      attach_function('open_bucket', 'open_bucket', [
          ProjectRef.by_value,
          :string, # bucket name
          :string, # encryption access/key
          :pointer # error string double pointer
      ], BucketRef.by_value)
    end
  end
end
