class YelpApi
  def self.resturants(location, food, unix)
    response = conn.get("/v3/businesses/search?") do |req|
      req.params[:location] = location
      req.params[:term] = food
      req.params[:open_at] = unix
    end
    JSON.parse(response.body, symbolize_names: true)    
  end
  
  private
  def self.conn
    Faraday.new("https://api.yelp.com") do |f|
      f.headers["Authorization"] = ENV["YELP_API_KEY"]
    end
  end
end