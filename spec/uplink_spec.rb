require 'openssl'
require_relative 'helpers/storj_options'
include LibUplinkTest

RSpec.describe LibUplink::Uplink do
  let(:default_path) {File.join %W(#{__dir__} .. .. options.yml)}
  let(:options) {{uplink_config: {
      skip_peer_ca_whitelist: true
  }}}
  # TODO: exercise both options_path and kwargs?
  let(:uplink) do
    # described_class.new(options_path: default_path)
    described_class.new(**options)
  end

  describe 'new' do
    it 'returns an instance of the described class' do
      expect(uplink).to be_an_instance_of(described_class)
    end
  end

  describe '@handle' do
    it 'is an instance of the struct wrapper corresponding to its C analogue' do
      expect(uplink.ref).to be_an_instance_of(described_class::C_ANALOGUE)
    end
  end

  describe '#open_project' do
    # TODO: cleanup
    let(:satellite_addr) {'127.0.0.1:10000'}
    let(:api_key) {'13YqeFUFzmaNSeqmLSVCZniJEcAHt9qSsqUrjZUeEgrxnqcoL7HnxUKNgTR4G53x8giTvT4GPJiMtbUnUXKfpWybTQpRF87Z6YJL3Dz'}

    context 'without error' do
      let(:project) {uplink.open_project satellite_addr, api_key}

      it 'returns an instance of the desired class' do
        expect(project).to be_an_instance_of(::LibUplink::Project)
      end
    end
  end
end
