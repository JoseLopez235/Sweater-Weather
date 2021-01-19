class Munchie
  attr_reader :travel_time,
              :destination_city,
              :forecast,
              :resturant
  def initialize(travel_time, weather, end_city, food)
   @travel_time = time_to_destination(travel_time)
   @destination_city = end_city
   @forecast = current_forecast(weather)
   @resturant = search_resturant(weather, travel_time, end_city, food)
  end

  def time_to_destination(data)
    "#{data[:route][:realTime] / 3600 } hours #{data[:route][:realTime] / 60 % 60}min"
  end

  def current_forecast(weather)
    { 
      summary: weather[:current][:weather][0][:description],
      temperature: "#{weather[:current][:temp]}"
     }
  end
  
  def search_resturant(weather, travel_time, end_city, food)
    unix = weather[:current][:dt] + travel_time[:route][:realTime]
    resturants = YelpApi.resturants(end_city, food, unix)

    { 
      name: resturants[:businesses][0][:name],
      address: resturants[:businesses][0][:location][:display_address].join(" ")
     }
  end
end