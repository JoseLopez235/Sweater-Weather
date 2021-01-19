require 'rails_helper'

RSpec.describe MunchiesSearchFacade do
  it "munchie data" do
    VCR.use_cassette('mucnhies') do
      start_city = "denver,co"
      end_city = "Pueblo, CO"
      food = "chinese"
      facade = MunchiesSearchFacade.find_munchies(start_city, end_city, food)

      expect(facade.destination_city).to eq(end_city)
      expect(facade.forecast).to be_a(Hash)
      expect(facade.resturant).to be_a(Hash)
      expect(facade.travel_time).to be_a(String)
    end
  end
end