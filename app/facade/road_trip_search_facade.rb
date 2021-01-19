class RoadTripSearchFacade
  def self.road_trip(start_city, end_city)
    travel_time = GeoMapApi.travel(start_city, end_city)

    return RoadTrip.new(travel_time,start_city,end_city) if travel_time[:info][:statuscode] == 402
    location = GeoMapApi.geo_location(end_city)
    weather = WeatherApi.weather_forecast(location[:lat], location[:lng])
    RoadTrip.new(travel_time, weather, start_city, end_city)
  end
end