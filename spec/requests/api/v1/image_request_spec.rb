require 'rails_helper'

describe 'image api' do
  it 'should reacieve image of city being searched' do
    VCR.use_cassette('images') do
      location = "denver,co"

      get "/api/v1/backgrounds?location=#{location}"

      expect(response).to be_successful

      image = JSON.parse(response.body, symbolize_names: true)

      expect(image).to be_a(Hash)
      expect(image[:data][:id]).to eq(nil)
      expect(image[:data][:attributes]).to be_a(Hash)
      expect(image[:data][:attributes][:image]).to be_a(Hash)
      expect(image[:data][:attributes][:image][:location]).to be_a(String)
      expect(image[:data][:attributes][:image][:image_url]).to be_a(String)
      expect(image[:data][:attributes][:image][:credits]).to be_a(Hash)
      expect(image[:data][:attributes][:image][:credits][:source]).to be_a(String)
      expect(image[:data][:attributes][:image][:credits][:logo]).to be_a(String)
      expect(image[:data][:attributes][:image][:credits][:author]).to be_a(String)
      expect(image[:data][:attributes][:image][:credits][:author_url]).to be_a(String)
      expect(image[:data][:attributes][:image][:credits][:original_image_post]).to be_a(String)
    end
  end
end