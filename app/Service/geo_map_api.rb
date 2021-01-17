class GeoMapApi
  def self.geo_location(location)
    response = conn.get("/geocoding/v1/address?") do |req|
      req.params[:location] = location
    end
    coords = JSON.parse(response.body, symbolize_names: true)
    coords[:results][0][:locations][0][:latLng]
  end
  
  private
  def self.conn
    Faraday.new("http://www.mapquestapi.com") do |f|
      f.params["key"] = ENV["MAP_API_KEY"]
    end
  end
end