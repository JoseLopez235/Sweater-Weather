require "rails_helper"

RSpec.describe WeatherFacade do
  it "current weather forecast method" do
    VCR.use_cassette('weather_forecast') do
      VCR.use_cassette('geo_location') do
        denver = "denver,co"
        facade = WeatherFacade.weather_forecast(denver)

        expect(facade).to be_a(Weather)
      end
    end
  end
end