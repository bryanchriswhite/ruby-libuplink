module LibUplinkTest
  require 'ruby-libuplink'

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
