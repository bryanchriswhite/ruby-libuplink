require_relative 'helpers/storj_options'
include LibUplinkTest

RSpec.describe LibUplink::Project do
  # let(:default_path) {File.join %W(#{__dir__} .. .. options.yml)}
  let(:options) {{uplink: {skip_peer_ca_whitelist: true}}}
  let(:satellite_addr) {'127.0.0.1:10000'}
  let(:api_key_str) {'13YqeFUFzmaNSeqmLSVCZniJEcAHt9qSsqUrjZUeEgrxnqcoL7HnxUKNgTR4G53x8giTvT4GPJiMtbUnUXKfpWybTQpRF87Z6YJL3Dz'}
  let(:uplink) {LibUplink::Uplink.new(**options)}
  let(:instance) {test_project}

  let(:bucket_name) {'test-bucket1'}

  describe '@ref' do
    it 'is an instance of the struct wrapper corresponding to its C analogue' do
      expect(instance.ref).to be_an_instance_of(described_class::C_ANALOGUE)
    end
  end

  # describe "#close" do
  #
  # end

  # describe '#salted_key_from_passphrase' do
  #
  # end

  describe '#create_bucket' do
    let(:bucket_cfg) {LibUplink::BucketConfig.new}

    context 'without error' do
      let(:bucket) {instance.create_bucket(bucket_name, bucket_cfg)}

      it 'returns an instance of a bucket' do
        expect(bucket).to be_a(LibUplink::Ext::Storj::BucketRef)
      end
    end
  end

  describe '#open_bucket' do
    context 'without error' do
      let(:bucket) {test_project.open_bucket bucket_name, test_encryption_access}

      it 'returns an instance of the desired class' do
        expect(bucket).to be_an_instance_of(::LibUplink::Bucket)
      end
    end
  end
end
