require 'rails_helper'

RSpec.describe Weather do
  it "current_weather_data" do
    VCR.use_cassette("weather_forecast") do
      weather = WeatherApi.weather_forecast(39.738453, -104.984853)
      poro = Weather.new(weather)
      expect(poro.current_weather_data).to be_a(Hash)
      expect(poro.current_weather_data[:datetime]).to eq("2021-01-16 21:45:35.000000000 -0500")
      expect(poro.current_weather_data[:sunrise]).to eq("2021-01-16 09:18:33 -0500")
      expect(poro.current_weather_data[:sunset]).to eq("2021-01-16 19:00:41 -0500")
      expect(poro.current_weather_data[:temp]).to eq(32.41)
      expect(poro.current_weather_data[:feels_like]).to eq(25.63)
      expect(poro.current_weather_data[:humidity]).to eq(59)
      expect(poro.current_weather_data[:uvi]).to eq(0)
      expect(poro.current_weather_data[:visibility]).to eq(10000)
      expect(poro.current_weather_data[:conditions]).to eq("overcast clouds")
      expect(poro.current_weather_data[:icon]).to eq("04n")
    end
  end

  it "daily_weather_data" do
    VCR.use_cassette("weather_forecast") do
      weather = WeatherApi.weather_forecast(39.738453, -104.984853)
      poro = Weather.new(weather)
      expect(poro.daily_weather_data).to be_a(Array)
      expect(poro.daily_weather_data.count).to eq(5)
      expect(poro.daily_weather_data[0][:date]).to eq("2021-1-16")
      expect(poro.daily_weather_data[0][:sunrise]).to eq("2021-01-16 09:18:33 -0500")
      expect(poro.daily_weather_data[0][:sunset]).to eq("2021-01-16 19:00:41 -0500")
      expect(poro.daily_weather_data[0][:max_temp]).to eq(43.92)
      expect(poro.daily_weather_data[0][:min_temp]).to eq(32.41)
      expect(poro.daily_weather_data[0][:conditions]).to eq("clear sky")
      expect(poro.daily_weather_data[0][:icon]).to eq("01d")
    end
  end

  it "hourly_weather_data" do
    VCR.use_cassette("weather_forecast") do
      weather = WeatherApi.weather_forecast(39.738453, -104.984853)
      poro = Weather.new(weather)
      expect(poro.hourly_weather_data.count).to eq(8)
      expect(poro.hourly_weather_data[0][:time]).to eq("21-00-00")
      expect(poro.hourly_weather_data[0][:temperature]).to eq(32.41)
      expect(poro.hourly_weather_data[0][:wind_speed]).to eq("3.13")
      expect(poro.hourly_weather_data[0][:wind_direction]).to eq("ESE")
      expect(poro.hourly_weather_data[0][:conditions]).to eq("overcast clouds")
      expect(poro.hourly_weather_data[0][:icon]).to eq("04n")
    end
  end
end