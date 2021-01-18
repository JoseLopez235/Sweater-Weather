class Api::V1::WeatherController < ApplicationController
  def index
    weather = WeatherFacade.weather_forecast(params[:location])
    render json: ForecastSerializer.new(weather) 
  end
end