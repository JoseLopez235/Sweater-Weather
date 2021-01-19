require 'rails_helper'

RSpec.describe ImageSearchFacade do
  it "image data" do
    VCR.use_cassette('images') do
      denver = "denver,co"
      facade = ImageSearchFacade.image_search(denver)

      expect(facade).to be_a(Image)
    end
  end
end