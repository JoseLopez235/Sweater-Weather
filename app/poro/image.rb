class Image 
  attr_reader :image
  def initialize(image, location) 
    @image = image_information(image, location)
  end

  def image_information(image, location)
    { 
      location: location,
      image_url: image[:src][:original],
      credits: { 
        source: "https://www.pexels.com",
        logo: "https://images.pexels.com/lib/api/pexels-white.png",
        author: image[:photographer],
        author_url: image[:photographer_url],
        original_image_post: image[:url]
       }
     }
  end
end