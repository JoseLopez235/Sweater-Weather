class WeatherApi
  def self.weather_forecast(lat, lon)
    response = conn.get("/data/2.5/onecall?") do |req|
      req.params[:lat] = lat
      req.params[:lon] = lon
      req.params[:units] = "imperial"
      req.params[:exclude] = "minutely, alert"
    end
    JSON.parse(response.body, symbolize_names: true)    
  end
  
  private
  def self.conn
    Faraday.new("https://api.openweathermap.org") do |f|
      f.params["appid"] = ENV["WEATHER_API_KEY"]
    end
  end
end