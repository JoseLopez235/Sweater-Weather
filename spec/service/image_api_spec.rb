require 'rails_helper'

RSpec.describe ImageApi do
  describe "Methods" do
    it "image location" do
      VCR.use_cassette("images") do
        images = ImageApi.image_location("denver,co")
        
        expect(images).to be_a(Hash)
        expect(images[:photos].count).to eq(15)
      end
    end
  end
end