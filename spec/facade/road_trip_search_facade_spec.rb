require "rails_helper"

RSpec.describe RoadTripSearchFacade do
  it "road trip method" do
    VCR.use_cassette('road_trip') do
      VCR.use_cassette('weather_forecast_end_city') do
        VCR.use_cassette('geo_location_end_city') do
          start_city = "Denver, CO"
          end_city = "Estes Park, CO"
          facade = RoadTripSearchFacade.road_trip(start_city, end_city)

          expect(facade.end_city).to eq(end_city)
          expect(facade.start_city).to eq(start_city)
          expect(facade.travel_time).to be_a(String)
          expect(facade.weather_at_eta).to be_a(Hash)
        end
      end
    end
  end

  it "should return error if route is impossible" do
    VCR.use_cassette('impossible_road_trip_japan') do
      start_city = "Denver, CO"
      end_city = "japan"
      facade = RoadTripSearchFacade.road_trip(start_city, end_city)

      expect(facade.travel_time).to eq("Impossible Route")
      expect(facade.weather_at_eta).to eq({})
    end
  end
end