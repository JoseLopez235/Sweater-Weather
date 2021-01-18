class Weather
  attr_reader :current_weather_data,
              :daily_weather_data,
              :hourly_weather_data

  def initialize(weather_data)
    @current_weather_data = current_weather(weather_data[:current])
    @daily_weather_data = daily_weather(weather_data[:daily])
    @hourly_weather_data = hourly_weather(weather_data[:hourly])
  end

  def current_weather(data)
    {
      datetime: Time.at(data[:dt]),
      sunrise: Time.at(data[:sunrise]),
      sunset: Time.at(data[:sunset]),
      temp: data[:temp],
      feels_like: data[:feels_like],
      humidity: data[:humidity],
      uvi: data[:uvi],
      visibility: data[:visibility],
      conditions: data[:weather][0][:description],
      icon: data[:weather][0][:icon]
     }
  end

  def daily_weather(data)
    weather = []
    5.times do |i|
      weather_data = data[i]
      date = Time.at(weather_data[:dt])
      weather << { 
        date: "#{date.year}-#{date.month}-#{date.day}", 
        sunrise: Time.at(weather_data[:sunrise]),
        sunset: Time.at(weather_data[:sunset]),
        max_temp: weather_data[:temp][:max],
        min_temp: weather_data[:temp][:min],
        conditions: weather_data[:weather][0][:description],
        icon: weather_data[:weather][0][:icon]
      }
    end
    weather
  end

  def hourly_weather(data)
    weather = []
    8.times do |i|
      weather_data = data[i]
      date = Time.at(weather_data[:dt])
      weather << { 
        time: Time.at(weather_data[:dt]).strftime('%H-%M-%S'),
        temperature: weather_data[:temp],
        wind_speed: "#{weather_data[:wind_speed]}",
        wind_direction: deg_to_compass(weather_data[:wind_deg]),
        conditions: weather_data[:weather][0][:description],
        icon: weather_data[:weather][0][:icon]
      }
    end
    weather
  end

  def deg_to_compass(num)
    val = ((num/22.5)+0.5)
    arr=["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    arr[(val % 16)]
  end
end