require 'rails_helper'

RSpec.describe GeoMapApi do
  describe "Methods" do
    it "geo_location to grab lat and lng" do
      VCR.use_cassette("geo_location") do
        location = GeoMapApi.geo_location("denver,co")
        expect(location).to be_a(Hash)
        expect(location[:lat]).to be_a(Float)
        expect(location[:lng]).to be_a(Float)
      end
    end

    it "gets the real time to travel" do
      VCR.use_cassette("road_trip") do
        location = GeoMapApi.travel("denver,co", "Estes Park, CO")
        expect(location[:route][:realTime]).to be_a_kind_of(Numeric)
      end
    end

    it "returns error if travel is impossible" do
      VCR.use_cassette("impossible_road_trip") do
        location = GeoMapApi.travel("denver,co", "japan")

        expect(location[:info][:messages][0]).to eq("We are unable to route with the given locations.")
      end
    end
  end
end