# frozen_string_literal: true

RSpec.describe AdSerializer do
  subject(:serializer) { described_class.new([ad], links:) }

  let(:ad) { create(:ad) }

  let(:links) do
    {
      first: '/path/to/first/page',
      last: '/path/to/last/page',
      next: '/path/to/next/page'
    }
  end

  let(:attributes) do
    available_attributes = %i[title description city lat lon]
    ad.values.select { |attr| available_attributes.include?(attr) }
  end

  it 'returns ad representation' do
    expect(serializer.serializable_hash).to a_hash_including(
      data: [
        {
          id: ad.id.to_s,
          type: :ad,
          attributes:
        }
      ],
      links:
    )
  end
end
