require 'rails_helper'

RSpec.describe ImageApi do
  describe "Methods" do
    it "image location" do
      VCR.use_cassette("images") do
        images = ImageApi.image_location("denver,co")

        expect(images).to be_a(Hash)
        expect(images).to include(:photos)
        expect(images[:photos].count).to eq(15)
        expect(images[:photos][0]).to include(:url)
        expect(images[:photos][0][:url]).to be_a(String)
        expect(images[:photos][0]).to include(:photographer)
        expect(images[:photos][0][:photographer]).to be_a(String)
        expect(images[:photos][0][:photographer_url]).to be_a(String)
        expect(images[:photos][0]).to include(:src)
        expect(images[:photos][0][:src]).to be_a(Hash)
        expect(images[:photos][0][:src]).to include(:original)
        expect(images[:photos][0][:src][:original]).to be_a(String)
      end
    end
  end
end