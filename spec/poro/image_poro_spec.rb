require 'rails_helper'

RSpec.describe Image do
  it "image data method" do
    VCR.use_cassette('images') do
      denver = "denver,co"
      images = ImageApi.image_location("denver,co")
      poro = Image.new(images[:photos].sample, denver)

      expect(poro.image).to be_a(Hash)
      expect(poro.image[:image_url]).to be_a(String)
      expect(poro.image[:location]).to be_a(String)
      expect(poro.image[:credits]).to be_a(Hash)
      expect(poro.image[:credits][:source]).to be_a(String)
      expect(poro.image[:credits][:logo]).to be_a(String)
      expect(poro.image[:credits][:author]).to be_a(String)
      expect(poro.image[:credits][:author_url]).to be_a(String)
      expect(poro.image[:credits][:original_image_post]).to be_a(String)
    end
  end
end