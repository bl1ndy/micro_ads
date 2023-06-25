# frozen_string_literal: true

RSpec.describe GeocoderService::Client, type: :client do
  subject(:client) { described_class.new(connection:) }

  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }

  before do
    stubs.get('/') { [status, headers, body.to_json] }
  end

  describe '#geocode with existing city' do
    let(:coordinates) { [1.00, 2.00] }
    let(:body) { { data: { coordinates: } } }

    it 'returns coordinates' do
      expect(client.geocode('Existing city')).to eq(coordinates)
    end
  end

  describe '#geocode with missing city' do
    let(:body) { { data: { coordinates: nil } } }

    it 'does not return coordinates' do
      expect(client.geocode('Missing city')).to be_nil
    end
  end
end
