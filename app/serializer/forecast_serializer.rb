class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  attributes :current_weather_data, :daily_weather_data, :hourly_weather_data
end