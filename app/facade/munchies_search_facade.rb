class MunchiesSearchFacade
  def self.find_munchies(start_city, end_city, food)
    travel_time = GeoMapApi.travel(start_city, end_city)
    location = GeoMapApi.geo_location(end_city)
    weather = WeatherApi.weather_forecast(location[:lat], location[:lng])
    resturants = YelpApi.resturants(end_city, food)
    Munchie.new(travel_time, weather, end_city, resturants)
  end
end