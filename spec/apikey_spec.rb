require_relative 'helpers/storj_options'
include LibUplinkTest

RSpec.describe LibUplink::APIKey do
  let(:api_key_str) {'13YqeFUFzmaNSeqmLSVCZniJEcAHt9qSsqUrjZUeEgrxnqcoL7HnxUKNgTR4G53x8giTvT4GPJiMtbUnUXKfpWybTQpRF87Z6YJL3Dz'}
  let(:instance) {LibUplink::APIKey.new api_key_str}

  describe '@ref' do
    it 'is an instance of the struct wrapper corresponding to its C analogue' do
      expect(instance.ref).to be_an_instance_of(described_class::C_ANALOGUE)
    end
  end
end
