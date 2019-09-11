module LibUplink
  module Ext
    # NB: Ruby's ffi doesn't allow assigning to :string pointer types.
    #
    #     You can use `FFI::MemoryPointer.from_string` to create a
    #     string pointer from a ruby string. Or use the
    #     `FFI::Pointer#write_string` method to update an existing
    #     string (or generic) pointer; see below
    #
    # NB: All pointer types use have
    #       `read_<type> (FFI::Pointer#read_<type>)`
    #                 and
    #       `write_<type> (FFI::Pointer#write_<type>)`
    #     methods to read and write respectively

    module Storj
      extend FFI::Library

      # enums
      enum :cipher_suite, [
          :enc_unspecified, 0,
          :enc_null,
          :enc_aesgcm,
          :enc_secret_box,
      ]

      enum :redundancy_algorithm, [
          :invalid_redundancy_algorithm, 0,
          :reed_solomon
      ]

      enum :list_direction, [
          :before, -2,
          :backward,
          :forward,
          :after
      ]

      # ref types
      class APIKeyRef < FFI::Struct
        layout :_handle, :int64
      end

      class UplinkRef < FFI::Struct
        layout :_handle, :int64
      end

      class ProjectRef < FFI::Struct
        layout :_handle, :int64
      end

      class BucketRef < FFI::Struct
        layout :_handle, :int64
      end

      class ObjectRef < FFI::Struct
        layout :_handle, :int64
      end

      class DownloaderRef < FFI::Struct
        layout :_handle, :int64
      end

      class UploaderRef < FFI::Struct
        layout :_handle, :int64
      end

      class EncryptionAccessRef < FFI::Struct
        layout :_handle, :int64
      end

      # struct types
      class UplinkConfigTLS < FFI::Struct
        layout :skip_peer_ca_whitelist, :bool

        def initialize(skip_peer_ca_whitelist:)
          self[:skip_peer_ca_whitelist] = skip_peer_ca_whitelist
        end
      end

      class UplinkConfigVolatile < FFI::Struct
        layout :tls, UplinkConfigTLS

        def initialize(skip_peer_ca_whitelist:)
          self[:tls] = ::LibUplink::Ext::Storj::UplinkConfigTLS
                           .new(skip_peer_ca_whitelist: skip_peer_ca_whitelist)
        end
      end

      class UplinkConfig < FFI::Struct
        layout :volatile, UplinkConfigVolatile

        def initialize(skip_peer_ca_whitelist:)
          self[:volatile] = ::LibUplink::Ext::Storj::UplinkConfigVolatile
                                .new(skip_peer_ca_whitelist: skip_peer_ca_whitelist)
        end
      end

      class EncryptionParameters < FFI::Struct
        layout :cipher_suite, :cipher_suite,
               :block_size, :int32
      end

      class RedundancyScheme < FFI::Struct
        layout :algorithm, :redundancy_algorithm,
               :share_size, :int32,
               :required_shares, :int16,
               :repair_shares, :int16,
               :optimal_shares, :int16,
               :total_shares, :int16
      end

      class BucketInfo < FFI::Struct
        layout :name, :string,
               :created, :int64,
               :path_cipher, :cipher_suite,
               :segment_size, :uint64,
               :encryption_parameters, EncryptionParameters,
               :redundancy_scheme, RedundancyScheme
      end

      class BucketConfig < FFI::Struct
        layout :path_cipher, :cipher_suite,
               :encryption_parameters, EncryptionParameters,
               :redundancy_scheme, RedundancyScheme
      end

      class BucketListOptions < FFI::Struct
        layout :more, :bool,
               :items, :pointer, # *BucketInfo
               :length, :int32
      end

      class ObjectInfo < FFI::Struct
        layout :version, :uint32,
               :bucket, BucketInfo,
               :path, :string,
               :is_prefix, :bool,
               :content_type, :string,
               :size, :int64,
               :created, :int64,
               :modified, :int64,
               :expires, :int64
      end

      class ObjectList < FFI::Struct
        layout :bucket, :string,
               :prefix, :string,
               :more, :bool,
               :items, :pointer, # *ObjectInfo
               :length, :int32
      end

      class UploadOptions < FFI::Struct
        layout :content_type, :string,
               :expires, :int64
      end

      class ListOptions < FFI::Struct
        layout :prefix, :string,
               :cursor, :string,
               :delimiter, :char,
               :recursive, :bool,
               :direction, :list_direction,
               :limit, :int64
      end

      class ObjectMeta < FFI::Struct
        layout :bucket, :string,
               :path, :string,
               :is_prefix, :bool,
               :content_type, :string,
               :created, :int64,
               :modified, :int64,
               :expires, :int64,
               # TODO: should be int64 ?
               :size, :uint64,
               :checksum_bytes, :pointer, # *uint8_t
               # TODO: should be int32 ?
               :checksum_length, :uint64
      end
    end
  end
end
