require 'rails_helper'

RSpec.describe ImageSearchFacade do
  it "image data" do
    VCR.use_cassette('images') do
      denver = "denver,co"
      facade = ImageSearchFacade.image_search(denver)

      expect(facade.image).to be_a(Hash)
      expect(facade.image[:image_url]).to be_a(String)
      expect(facade.image[:location]).to be_a(String)
      expect(facade.image[:credits]).to be_a(Hash)
      expect(facade.image[:credits][:source]).to be_a(String)
      expect(facade.image[:credits][:logo]).to be_a(String)
      expect(facade.image[:credits][:author]).to be_a(String)
      expect(facade.image[:credits][:author_url]).to be_a(String)
      expect(facade.image[:credits][:original_image_post]).to be_a(String)
    end
  end
end