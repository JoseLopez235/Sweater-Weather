require "rails_helper"

RSpec.describe RoadTripSearchFacade do
  it "road trip method" do
    VCR.use_cassette('road_trip') do
      VCR.use_cassette('weather_forecast_end_city') do
        VCR.use_cassette('geo_location_end_city') do
          start_city = "Denver, CO"
          end_city = "Estes Park, CO"
          facade = RoadTripSearchFacade.road_trip(start_city, end_city)

          expect(facade).to be_a(RoadTrip)
        end
      end
    end
  end
end