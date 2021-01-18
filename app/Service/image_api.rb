class ImageApi
  def self.image_location(location)
    response = conn.get("/v1/search?") do |req|
      req.params[:query] = "#{location} city"
    end
    JSON.parse(response.body, symbolize_names: true)    
  end
  
  private
  def self.conn
    Faraday.new("https://api.pexels.com") do |f|
      f.headers["Authorization"] = ENV["IMAGE_API_KEY"]
    end
  end
end