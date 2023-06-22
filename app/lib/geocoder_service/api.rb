# frozen_string_literal: true

module GeocoderService
  module Api
    def geocode(city)
      response = connection.get('/') do |request|
        request.params[:city] = city
      end

      response.body.dig('data', 'coordinates') if response.success?
    end
  end
end
