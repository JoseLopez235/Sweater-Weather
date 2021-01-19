class GeoMapApi
  def self.geo_location(location)
    response = conn.get("/geocoding/v1/address?") do |req|
      req.params[:location] = location
    end
    coords = JSON.parse(response.body, symbolize_names: true)
    coords[:results][0][:locations][0][:latLng]
  end
  
  def self.travel(start_city, end_city)
    response = conn.get("/directions/v2/route?") do |req|
      req.params[:from] = start_city
      req.params[:to] = end_city
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  def self.conn
    Faraday.new("http://www.mapquestapi.com") do |f|
      f.params["key"] = ENV["MAP_API_KEY"]
    end
  end
end