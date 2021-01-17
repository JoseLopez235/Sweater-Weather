class ImageSearchFacade
  def self.image_search(location)
    images = ImageApi.image_location(location)
    image = images[:photos].sample
    Image.new(image,location)
  end
end