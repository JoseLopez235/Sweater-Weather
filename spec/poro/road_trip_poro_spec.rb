require "rails_helper"

RSpec.describe RoadTripSearchFacade do
  it "road trip method" do
    VCR.use_cassette('road_trip') do
      VCR.use_cassette('weather_forecast_end_city') do
        VCR.use_cassette('geo_location_end_city') do
          start_city = "Denver, CO"
          end_city = "Estes Park, CO"
          location = GeoMapApi.geo_location(end_city)
          weather = WeatherApi.weather_forecast(location[:lat], location[:lng])
          travel_time = GeoMapApi.travel(start_city, end_city)

          poro = RoadTrip.new(travel_time, weather, start_city, end_city)

          expect(poro.end_city).to eq(end_city)
          expect(poro.start_city).to eq(start_city)
          expect(poro.travel_time).to be_a(String)
          expect(poro.weather_at_eta).to be_a(Hash)
        end
      end
    end
  end

  it "should return error if route is impossible" do
    VCR.use_cassette('impossible_road_trip_japan') do
      VCR.use_cassette('impossible_location') do
        start_city = "Denver, CO"
        end_city = "japan"
        location = GeoMapApi.geo_location(end_city)
        weather = WeatherApi.weather_forecast(location[:lat], location[:lng])
        travel_time = GeoMapApi.travel(start_city, end_city)
        
        poro = RoadTrip.new(travel_time, weather, start_city, end_city)

        expect(poro.travel_time).to eq("Impossible Route")
        expect(poro.weather_at_eta).to eq({})
      end
    end
  end
end