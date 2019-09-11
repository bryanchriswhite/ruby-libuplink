module LibUplink
  DEFAULT_CIPHER_SUITE = :enc_aesgcm

  class EncryptionParameters
    attr_reader :value, :cipher_suite, :block_size

    DEFAULT_BLOCK_SIZE = 2048

    def initialize(path_cipher = nil, block_size = nil)
      @value = LibUplink::Ext::Storj::EncryptionParameters.new
      self.cipher_suite = path_cipher.nil? ? DEFAULT_CIPHER_SUITE : path_cipher
      self.block_size = block_size.nil? ? DEFAULT_BLOCK_SIZE : path_cipher
    end

    def cipher_suite=(value)
      @cipher_suite = value
      @value[:cipher_suite] = value
    end

    def block_size=(value)
      @block_size = value
      @value[:block_size] = value
    end
  end

  class RedundancyScheme
    attr_reader :value, :share_size, :required_shares, :optimal_shares, :total_shares

    DEFAULT_ALGORITHM = :reed_solomon
    # TODO: cleanup/fix
    DEFAULT_SHARE_SIZE = 256
    DEFAULT_REQUIRED_SHARES = 4
    DEFAULT_REPAIR_SHARES = 6
    DEFAULT_OPTIMAL_SHARES = 8
    DEFAULT_TOTAL_SHARES = 10

    def initialize(path_cipher = nil, block_size = nil)
      @value = LibUplink::Ext::Storj::RedundancyScheme.new
    end

    def share_size=(value)
      @share_size = value
      @value[:share_size] = value
    end

    def required_shares=(value)
      @required_shares = value
      @value[:required_shares] = value
    end

    def repair_shares=(value)
      @repair_shares = value
      @value[:repair_shares] = value
    end

    def optimal_shares=(value)
      @optimal_shares = value
      @value[:optimal_shares] = value
    end

    def total_shares=(value)
      @total_shares = value
      @value[:total_shares] = value
    end
  end

  class BucketConfig
    attr_reader :value, :path_cipher, :encryption_parameters, :redundancy_scheme

    C_ANALOGUE = ::LibUplink::Ext::Storj::BucketConfig

    def initialize(path_cipher: nil, encryption_params: nil, redundancy_scheme: nil)
      @value = LibUplink::Ext::Storj::BucketConfig.new

      self.path_cipher = path_cipher.nil? ? DEFAULT_CIPHER_SUITE : path_cipher
      self.encryption_parameters = encryption_params.nil? ?
                                   EncryptionParameters.new : encryption_params
      self.redundancy_scheme = redundancy_scheme.nil? ?
                                RedundancyScheme.new : redundancy_scheme
    end

    def path_cipher=(value)
      @path_cipher = value
      @value[:path_cipher] = value
    end

    def encryption_parameters=(value)
      @encryption_parameters = value
      @value[:encryption_parameters] = value.value
    end

    def redundancy_scheme=(value)
      @redundancy_scheme = value
      @value[:redundancy_scheme] = value.value
    end
  end
end