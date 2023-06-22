# frozen_string_literal: true

RSpec.describe AdRoutes, type: :routes do
  before do
    geocoder_client = instance_double(GeocoderService::Client)
    allow(GeocoderService::Client).to receive(:new).and_return(geocoder_client)
    allow(geocoder_client).to receive(:geocode).with(any_args).and_return([])
  end

  describe 'GET /v1' do
    let(:user_id) { 101 }

    before do
      create_list(:ad, 3, user_id:)
    end

    it 'returns a collection of ads' do
      get '/v1'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /v1' do
    let(:user_id) { 101 }
    let(:auth_token) { 'auth.token' }
    let(:auth_service) { instance_double(AuthService::Client) }

    before do
      allow(AuthService::Client).to receive(:new).and_return(auth_service)
      allow(auth_service).to receive(:auth).with(auth_token).and_return(user_id)

      header 'Authorization', "Bearer #{auth_token}"
    end

    context 'when parameters are missing' do
      it 'returns an error' do
        post '/v1'

        expect(last_response.status).to eq(422)
      end
    end

    context 'with invalid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end

      it 'returns an error' do
        post('/v1', ad: ad_params)

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => I18n.t(:blank, scope: 'model.errors.ad.city'),
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end

    context 'when user_id is missing' do
      let(:user_id) { nil }
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      it 'returns an error' do
        post '/v1', ad: ad_params

        expect(last_response.status).to eq(403)
        expect(response_body['errors']).to include('detail' => I18n.t(:unauthorized, scope: 'api.errors'))
      end
    end

    context 'with valid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { Ad.last }

      it 'creates a new ad' do
        expect { post '/v1', ad: ad_params }
          .to change(Ad, :count).from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post('/v1', ad: ad_params)

        expect(response_body['data']).to a_hash_including(
          'id' => last_ad.id.to_s,
          'type' => 'ad'
        )
      end
    end
  end
end
