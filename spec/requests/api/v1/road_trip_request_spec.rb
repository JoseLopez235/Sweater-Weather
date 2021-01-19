require 'rails_helper'

describe "road trip" do
  it "returns road trip information" do
    VCR.use_cassette('geo_location_trip') do
      user = User.create(email: "whatever@example.com", password: "1234", password_confirmation: "1234")


      trip = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": user.api_key
      }

      post "/api/v1/road_trip", params: trip.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip[:id]).to eq(nil)
      expect(road_trip[:data][:type]).to eq("roadtrip")
      expect(road_trip[:data][:attributes][:start_city]).to eq("Denver,CO")
      expect(road_trip[:data][:attributes][:end_city]).to eq("Pueblo,CO")
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a_kind_of(Numeric)
      expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end
  end

  it "returns road trip object with errors if route is impossible" do
    VCR.use_cassette('road_trip_japan') do
      user = User.create(email: "whatever@example.com", password: "1234", password_confirmation: "1234")

      trip = {
        "origin": "Denver,CO",
        "destination": "japan",
        "api_key": user.api_key
      }

      post "/api/v1/road_trip", params: trip.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip[:id]).to eq(nil)
      expect(road_trip[:data][:type]).to eq("roadtrip")
      expect(road_trip[:data][:attributes][:start_city]).to eq("Denver,CO")
      expect(road_trip[:data][:attributes][:end_city]).to eq("japan")
      expect(road_trip[:data][:attributes][:travel_time]).to eq("Impossible Route")
      expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
    end
  end

  it "returns an error if api key dosnt match" do
    user = User.create(email: "whatever@example.com", password: "1234", password_confirmation: "1234")


      trip = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h4539h4"
      }

      post "/api/v1/road_trip", params: trip.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip[:error]).to eq("Unauthorized")
  end
end