class RoadTrip
  attr_reader :travel_time,
              :weather_at_eta,
              :start_city, 
              :end_city
  def initialize(travel_time, weather=nil, start_city, end_city) 
    @travel_time = time_to_destination(travel_time)
    @weather_at_eta = daily_weather(weather, travel_time)
    @start_city = start_city
    @end_city = end_city
  end

  def time_to_destination(data)
    return "Impossible Route" if data[:info][:statuscode] == 402
    "#{data[:route][:realTime] / 3600 }h#{data[:route][:realTime] / 60 % 60}m"
  end
  
  def daily_weather(weather_data, travel_time)
    return {} if travel_time[:info][:statuscode] == 402
    current_time = Time.at(weather_data[:current][:dt]).strftime('%H %M')
    current_time = current_time.split
    hour_travel_time = travel_time[:route][:realTime] / 3600
    minute_travel_time = travel_time[:route][:realTime] / 60 % 60
    time_at_eta = ("#{(current_time[0].to_i + hour_travel_time)} #{current_time[1].to_i + minute_travel_time}").split
    if time_at_eta.last.to_i > 59
     time_at_eta = "#{time_at_eta[0].to_i + (time_at_eta[1].to_i / 60)}"
    end
    weather_at_eta = nil
    weather_data[:hourly].each do |hourly|
      weather_at_eta = hourly if Time.at(hourly[:dt]).strftime('%H') == time_at_eta
    end
    { 
      temperature: weather_at_eta[:temp],
      conditions: weather_at_eta[:weather][0][:description],
     }
  end
end