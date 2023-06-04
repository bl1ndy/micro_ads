# frozen_string_literal: true

RSpec.describe Ads::CreateService do
  subject(:service) { described_class }

  let(:user_id) { 101 }

  context 'with valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'creates a new ad' do
      expect { service.call(ad: ad_params, user_id:) }
        .to change(Ad, :count).from(0).to(1)
    end

    it 'assigns ad' do
      result = service.call(ad: ad_params, user_id:)

      expect(result.ad).to be_a(Ad)
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

    it 'does not create ad' do
      expect { service.call(ad: ad_params, user_id:) }
        .not_to change(Ad, :count)
    end

    it 'assigns ad' do
      result = service.call(ad: ad_params, user_id:)

      expect(result.ad).to be_a(Ad)
    end
  end
end
