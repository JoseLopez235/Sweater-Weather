require 'rails_helper'

RSpec.describe YelpApi do
  describe "Methods" do
    it "resturants" do
      VCR.use_cassette("resturants") do
        resturants = YelpApi.resturants("Pueblo, CO", "chinese", 	
          1611095580)

        expect(resturants).to be_a(Hash)
        expect(resturants[:businesses][0][:categories][0][:title]).to eq("Chinese")
      end
    end
  end
end