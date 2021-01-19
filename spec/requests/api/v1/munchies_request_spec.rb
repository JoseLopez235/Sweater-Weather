require 'rails_helper'

describe "munchies" do
  it "should return trip information with resturant" do
    VCR.use_cassette('munchies') do
    
      origin = "Denver,CO"
      destination = "Pueblo,CO"
      food = "chinese"
  

      get "/api/v1/munchies?start=#{origin}&end=#{destination}&food=#{food}"

      expect(response).to be_successful

      munchies = JSON.parse(response.body, symbolize_names: true)

      expect(munchies).to be_a(Hash)
      expect(munchies[:data]).to eq(nil)
      expect(munchies[:type]).to eq(munchie)
      expect(munchies[:data][:attributes]).to be_a(Hash)
      expect(munchies[:data][:attributes][destination_city]).to eq(destination)
      expect(munchies[:data][:attributes][:travel_time]).to be_a(String)
      expect(munchies[:data][:attributes][:forecast]).to be_a(Hash)
      expect(munchies[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(munchies[:data][:attributes][:forecast][:temperature]).to be_a(String)
      expect(munchies[:data][:attributes][:resturant]).to be_a(Hash)
      expect(munchies[:data][:attributes][:resturant][:name]).to be_a(String)
      expect(munchies[:data][:attributes][:resturant][:address]).to be_a(String)
    end
  end
end