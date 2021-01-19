require 'rails_helper'

RSpec.describe MunchiesSearchFacade do
  it "munchie data" do
    VCR.use_cassette('mucnhies') do
      start_city = "denver,co"
      end_city = "Pueblo, CO"
      food = "chinese"
      facade = MunchiesSearchFacade.find_munchies(start_city, end_city, food)

      binding.pry
    end
  end
end