require 'rails_helper'

RSpec.describe WeatherApi do
  describe "Methods" do
    it "current weather forecast" do
      VCR.use_cassette("weather_forecast") do
        weather = WeatherApi.weather_forecast(39.738453, -104.984853)

        expect(weather).to be_a(Hash)
        expect(weather[:current]).to be_a(Hash)
        expect(weather[:current][:dt]).to be_a(Integer)
        expect(weather[:current][:sunrise]).to be_a(Integer)
        expect(weather[:current][:sunset]).to be_a(Integer)
        expect(weather[:current][:temp]).to be_a(Float)
        expect(weather[:current][:feels_like]).to be_a(Float)
        expect(weather[:current][:humidity]).to be_a_kind_of(Numeric)
        expect(weather[:current][:uvi]).to be_a_kind_of(Numeric)
        expect(weather[:current][:visibility]).to be_a_kind_of(Numeric)
        expect(weather[:current][:weather][0][:description]).to be_a(String)
        expect(weather[:current][:weather][0][:icon]).to be_a(String)
      end
    end

    it "daily weather forecast" do
      VCR.use_cassette("weather_forecast") do
        weather = WeatherApi.weather_forecast(39.738453, -104.984853)
        
        expect(weather[:daily]).to be_a(Array)
        expect(weather[:daily][0]).to be_a(Hash)
        expect(weather[:daily][0][:dt]).to be_a(Integer)
        expect(weather[:daily][0][:sunrise]).to be_a(Integer)
        expect(weather[:daily][0][:sunset]).to be_a(Integer)
        expect(weather[:daily][0][:temp]).to be_a(Hash)
        expect(weather[:daily][0][:weather][0][:description]).to be_a(String)
        expect(weather[:daily][0][:weather][0][:icon]).to be_a(String)
      end
    end

    it "hourly weather forecast" do
      VCR.use_cassette("weather_forecast") do
        weather = WeatherApi.weather_forecast(39.738453, -104.984853)

        expect(weather[:hourly]).to be_a(Array)
        expect(weather[:hourly][0]).to be_a(Hash)
        expect(weather[:hourly][0][:dt]).to be_a(Integer)
        expect(weather[:hourly][0][:temp]).to be_a(Float)
        expect(weather[:hourly][0][:wind_speed]).to be_a_kind_of(Numeric)
        expect(weather[:hourly][0][:wind_deg]).to be_a_kind_of(Numeric)
        expect(weather[:hourly][0][:weather][0][:description]).to be_a(String)
        expect(weather[:hourly][0][:weather][0][:icon]).to be_a(String)
      end
    end
  end
end