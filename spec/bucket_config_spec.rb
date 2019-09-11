require_relative 'helpers/storj_options'
include LibUplinkTest

RSpec.describe LibUplink::BucketConfig do
  let(:instance) {described_class.new}

  describe '@value' do
    it 'is an instance of the struct corresponding to its C analogue' do
      expect(instance.value).to be_an_instance_of(described_class::C_ANALOGUE)
    end

    # TODO
  end
end
