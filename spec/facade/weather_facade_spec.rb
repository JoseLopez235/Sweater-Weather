require "rails_helper"

RSpec.describe WeatherFacade do
  it "current weather forecast method" do
    VCR.use_cassette('weather_forecast') do
      VCR.use_cassette('geo_location') do
        denver = "denver,co"
        facade = WeatherFacade.weather_forecast(denver)

        expect(facade.current_weather_data).to be_a(Hash)
        expect(facade.current_weather_data[:datetime]).to eq("2021-01-16 21:43:30 -0500")
        expect(facade.current_weather_data[:sunrise]).to eq("2021-01-16 09:18:33 -0500")
        expect(facade.current_weather_data[:sunset]).to eq("2021-01-16 19:00:41 -0500")
        expect(facade.current_weather_data[:temp]).to eq(32.52)
        expect(facade.current_weather_data[:feels_like]).to eq(25.05)
        expect(facade.current_weather_data[:humidity]).to eq(58)
        expect(facade.current_weather_data[:uvi]).to eq(0)
        expect(facade.current_weather_data[:visibility]).to eq(10000)
        expect(facade.current_weather_data[:conditions]).to eq("overcast clouds")
        expect(facade.current_weather_data[:icon]).to eq("04n")
      end
    end
  end

  it "daily weather forecast method" do
    VCR.use_cassette('weather_forecast') do
      VCR.use_cassette('geo_location') do
        denver = "denver,co"
        facade = WeatherFacade.weather_forecast(denver)
        expect(facade.daily_weather_data).to be_a(Array)
        expect(facade.daily_weather_data.count).to eq(5)
        expect(facade.daily_weather_data[0][:date]).to eq("2021-1-16")
        expect(facade.daily_weather_data[0][:sunrise]).to eq("2021-01-16 09:18:33 -0500")
        expect(facade.daily_weather_data[0][:sunset]).to eq("2021-01-16 19:00:41 -0500")
        expect(facade.daily_weather_data[0][:max_temp]).to eq(44.33)
        expect(facade.daily_weather_data[0][:min_temp]).to eq(32.52)
        expect(facade.daily_weather_data[0][:conditions]).to eq("clear sky")
        expect(facade.daily_weather_data[0][:icon]).to eq("01d")
      end
    end
  end

  it "hourly weather forecast method" do
    VCR.use_cassette('weather_forecast') do
      VCR.use_cassette('geo_location') do
        denver = "denver,co"
        facade = WeatherFacade.weather_forecast(denver)

       expect(facade.hourly_weather_data.count).to eq(8)
       expect(facade.hourly_weather_data[0][:time]).to eq("21-00-00")
       expect(facade.hourly_weather_data[0][:temperature]).to eq(32.52)
       expect(facade.hourly_weather_data[0][:wind_speed]).to eq("4.29")
       expect(facade.hourly_weather_data[0][:wind_direction]).to eq("SE")
       expect(facade.hourly_weather_data[0][:conditions]).to eq("overcast clouds")
       expect(facade.hourly_weather_data[0][:icon]).to eq("04n")
      end
    end
  end
end