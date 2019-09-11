require_relative 'helpers/storj_options'
include LibUplinkTest

RSpec.describe LibUplink::Uplink do
  let(:default_path) {File.join %W(#{__dir__} .. .. options.yml)}
  let(:options) {{uplink_config: {skip_peer_ca_whitelist: true}}}
  let(:uplink) do
    described_class.new(**options)
  end

  describe 'new' do
    context 'with keyword args' do
      it 'returns an instance of the described class' do
        expect(described_class.new(**options)).to be_an_instance_of(described_class)
      end
    end

    context 'with options path' do
      it 'returns an instance of the described class' do
        expect(described_class.new(default_path)).to be_an_instance_of(described_class)
      end
    end
  end

  describe '@ref' do
    it 'is an instance of the struct wrapper corresponding to its C analogue' do
      expect(uplink.ref).to be_an_instance_of(described_class::C_ANALOGUE)
    end
  end

  describe '#open_project' do
    # TODO: cleanup

    context 'without error' do
      let(:project) {uplink.open_project test_satellite_addr, ''}

      it 'returns an instance of a project' do
        expect(project).to be_an_instance_of(::LibUplink::Project)
      end
    end
  end
end
