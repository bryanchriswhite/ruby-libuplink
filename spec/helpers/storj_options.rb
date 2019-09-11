module LibUplinkTest
  require 'ruby-libuplink'

  # TODO: make this nicer and compatible with storj-sim and/or `storj-sim network test`
  # maybe move to options.test.yml or something
  def test_satellite_addr
    '127.0.0.1:10000'
  end

  def test_encryption_access
    ''
  end

  def test_api_key
    '13YqeaSsbjpob3z5KBDt7i1xArUQC5ZsWThAJHNprttzuWRUpfBfBsCitBHoWV7jb9mnEfybs2Wr24vqYLzhAbcDxNNEqZkebSweCk2'
  end

  def test_uplink
    LibUplink::Uplink.new(uplink: {skip_peer_ca_whitelist: true})
  end

  def test_project
    test_uplink.open_project(test_satellite_addr, test_api_key)
  end

  # TODO:
  # def clean_buckets(&block)
  #   catch(:no_bucket) do
  #     return get_test_bucket_id do |id|
  #       instance.delete_bucket(id, &block)
  #     end
  #   end
  #
  #   yield if block_given?
  # end
  #
  # def clean_files(&block)
  #   catch(:no_bucket) do
  #     return get_test_bucket_id do |test_bucket_id|
  #       catch(:no_file) do
  #         get_test_file_id do |test_file_id|
  #           instance.delete_file(test_bucket_id, test_file_id, &block)
  #         end
  #       end
  #     end
  #   end
  #
  #   yield if block_given?
  # end
end
