require 'rails_helper'

RSpec.describe GeoMapApi do
  describe "Methods" do
    it "geo_location to grab lat and lng" do
      VCR.use_cassette("geo_location") do
        location = GeoMapApi.geo_location("denver,co")

        expect(location).to be_a(Hash)
        expect(location).to include(:lat)
        expect(location).to include(:lng)
        expect(location[:lat]).to be_a(Float)
        expect(location[:lng]).to be_a(Float)
      end
    end

    it "gets the real time to travel" do
      VCR.use_cassette("road_trip") do
        location = GeoMapApi.travel("denver,co", "Estes Park, CO")

        expect(location).to be_a(Hash)
        expect(location).to include(:route)
        expect(location[:route]).to be_a(Hash)
        expect(location[:route]).to include(:realTime)
        expect(location[:route][:realTime]).to be_a_kind_of(Numeric)
      end
    end

    it "returns error if travel is impossible" do
      VCR.use_cassette("impossible_road_trip") do
        location = GeoMapApi.travel("denver,co", "japan")

        expect(location).to be_a(Hash)
        expect(location).to include(:info)
        expect(location[:info]).to be_a(Hash)
        expect(location[:info]).to include(:messages)
        expect(location[:info][:messages]).to be_a(Array)
        expect(location[:info][:messages][0]).to eq("We are unable to route with the given locations.")
      end
    end
  end
end