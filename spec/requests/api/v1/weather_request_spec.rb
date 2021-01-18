require 'rails_helper'

describe "weather api" do
  it "retrieves weather of city being searched" do
    VCR.use_cassette('weather_forecast') do
      VCR.use_cassette('geo_location') do
        location = "denver,co"

        get "/api/v1/forecast?location=#{location}"

        expect(response).to be_successful

        weather = JSON.parse(response.body, symbolize_names: true)
        

        
        expect(weather).to be_a(Hash)
        expect(weather[:id]).to eq(nil)
        expect(weather[:data][:attributes].count).to eq(3)
        expect(weather[:data][:attributes][:current_weather_data]).to be_a(Hash)
        expect(weather[:data][:attributes][:current_weather_data][:datetime]).to be_a(String)
        expect(weather[:data][:attributes][:current_weather_data][:sunrise]).to be_a(String)
        expect(weather[:data][:attributes][:current_weather_data][:sunset]).to be_a(String)
        expect(weather[:data][:attributes][:current_weather_data][:temp]).to be_a(Float)
        expect(weather[:data][:attributes][:current_weather_data][:feels_like]).to be_a(Float)
        expect(weather[:data][:attributes][:current_weather_data][:humidity]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather_data][:uvi]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather_data][:visibility]).to be_a_kind_of(Numeric)
        expect(weather[:data][:attributes][:current_weather_data][:conditions]).to be_a(String)
        expect(weather[:data][:attributes][:current_weather_data][:icon]).to be_a(String)

        expect(weather[:data][:attributes][:daily_weather_data].count).to eq(5)
        expect(weather[:data][:attributes][:daily_weather_data][0][:date]).to be_a(String)
        expect(weather[:data][:attributes][:daily_weather_data][0][:sunrise]).to be_a(String)
        expect(weather[:data][:attributes][:daily_weather_data][0][:sunset]).to be_a(String)
        expect(weather[:data][:attributes][:daily_weather_data][0][:max_temp]).to be_a(Float)
        expect(weather[:data][:attributes][:daily_weather_data][0][:min_temp]).to be_a(Float)
        expect(weather[:data][:attributes][:daily_weather_data][0][:conditions]).to be_a(String)
        expect(weather[:data][:attributes][:daily_weather_data][0][:icon]).to be_a(String)

        expect(weather[:data][:attributes][:hourly_weather_data].count).to eq(8)
        expect(weather[:data][:attributes][:hourly_weather_data][0][:time]).to be_a(String)
        expect(weather[:data][:attributes][:hourly_weather_data][0][:temperature]).to be_a(Float)
        expect(weather[:data][:attributes][:hourly_weather_data][0][:wind_speed]).to be_a(String)
        expect(weather[:data][:attributes][:hourly_weather_data][0][:wind_direction]).to be_a(String)
        expect(weather[:data][:attributes][:hourly_weather_data][0][:conditions]).to be_a(String)
        expect(weather[:data][:attributes][:hourly_weather_data][0][:icon]).to be_a(String)
      end
    end
  end
end