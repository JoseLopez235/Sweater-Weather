require 'rails_helper'

RSpec.describe Munchie do
  it "munchie data" do
    VCR.use_cassette('poro_mucnhies') do
      start_city = "denver,co"
      end_city = "Pueblo, CO"
      food = "chinese"
      travel_time = GeoMapApi.travel(start_city, end_city)
      location = GeoMapApi.geo_location(end_city)
      weather = WeatherApi.weather_forecast(location[:lat], location[:lng])

      poro = Munchie.new(travel_time, weather, end_city, food)

      expect(poro.destination_city).to eq(end_city)
      expect(poro.forecast).to be_a(Hash)
      expect(poro.resturant).to be_a(Hash)
      expect(poro.travel_time).to be_a(String)
    end
  end
end