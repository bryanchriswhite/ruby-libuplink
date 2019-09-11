module LibUplink
  class Bucket < Errable
    attr_reader :ref

    C_ANALOGUE = ::LibUplink::Ext::Storj::BucketRef

    def initialize(project_ref)
      # NB: `new_err` initializes `@err`
      new_err
      @project_ref = project_ref
    end

    def self.create(project_ref, name, config)
      errable = Errable.new
      config_value = config.nil? ? nil : config.value
      bucket_info = Ext::Storj.create_bucket(project_ref, name, config_value, errable.err)

      errable.check_err

      BucketInfo.new(bucket_info)
    end

    def self.open(project_ref, name, encryption_access)
      # NB: `new_err` initializes `@err`
      errable = Errable.new
      @ref = ::LibUplink::Ext::Storj.open_bucket(project_ref, name, encryption_access, errable.err)

      errable.check_err

      initialize(@ref)
    end
  end

  class BucketInfo < Errable
    attr_reader :name,
                :created,
                :path_cipher,
                :segment_size,
                :encryption_parameters,
                :redundancy_scheme

    C_ANALOGUE = ::LibUplink::Ext::Storj::BucketInfo

    def initialize(bucket_info)
      bucket_info.map_layout.each do |name, value|
        self.instance_variable_set(name, value)
      end
    end
  end
end