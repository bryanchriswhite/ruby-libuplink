module LibUplink
  DEFAULT_CIPHER_SUITE = :enc_aesgcm

  class EncryptionParameters
    DEFAULT_BLOCK_SIZE = 2048

    def initialize(path_cipher = nil, block_size = nil)
      params = LibUplink::Ext::Storj::EncryptionParameters.new
      params[:cipher_suite] = path_cipher.nil? ? DEFAULT_CIPHER_SUITE : path_cipher
      params[:block_size] = block_size.nil? ? DEFAULT_BLOCK_SIZE : path_cipher
    end
  end

  class RedundancyScheme
    DEFAULT_ALGORITHM = :reed_solomon
    # TODO: cleanup/fix
    DEFAULT_SHARE_SIZE = 256
    DEFAULT_REQUIRED_SHARES = 4
    DEFAULT_REPAIR_SHARES = 6
    DEFAULT_OPTIMAL_SHARES = 8
    DEFAULT_TOTAL_SHARES = 10

    def initialize(path_cipher = nil, block_size = nil)
      params = LibUplink::Ext::Storj::RedundancyScheme.new
    end
  end

  class BucketConfig
    attr_accessor :path_cipher, :encryption_parameters, :redundancy_scheme

    def initialize(path_cipher: nil, encryption_params: nil, redundancy_scheme: nil)
      config = LibUplink::Ext::Storj::BucketConfig.new

      @path_cipher = path_cipher.nil? ? DEFAULT_CIPHER_SUITE : path_cipher
      @encryption_parameters = encryption_params.nil? ?
                                   EncryptionParameters.new : encryption_params
      @redundancy_scheme = redundancy_scheme.nil? ?
                                RedundancyScheme.new : redundancy_scheme
    end
  end
end