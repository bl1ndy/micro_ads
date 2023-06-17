# frozen_string_literal: true

module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id
      @ad.lat = coordinates&.first
      @ad.lon = coordinates&.last

      if @ad.valid?
        @ad.save_changes
      else
        fail!(@ad.errors)
      end
    end

    private

    def coordinates
      client = GeocoderService::Client.new
      @coordinates ||= client.geocode(@ad[:city])
    end
  end
end
