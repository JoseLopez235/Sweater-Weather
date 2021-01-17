class WeatherFacade
  def self.weather_forecast(location)
    location_data = GeoMapApi.geo_location(location)
    weather = WeatherApi.weather_forecast(location_data[:lat], location_data[:lng])
    Weather.new(weather)
  end
end