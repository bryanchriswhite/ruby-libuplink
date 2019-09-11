require_relative 'helpers/storj_options'
include LibUplinkTest

RSpec.describe LibUplink::Bucket do
  # describe 'new' do
  #   context 'without error' do
  #     it 'returns an instance of the described class' do
  #       expect(described_class.new()).to be_an_instance_of(described_class)
  #     end
  #   end
  # end

  describe 'create' do
    context 'without error' do
      it 'returns an instance of `BucketInfo`' do
        expect(described_class.create(test_project, bucket_name, bucket_config))
      end
    end
  end
end
