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
  end
end