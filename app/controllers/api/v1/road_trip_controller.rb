class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      trip = RoadTripSearchFacade.road_trip(params[:origin], params[:destination])
      render json: RoadtripSerializer.new(trip)
    else
      render json: {error: "Unauthorized"}, status:401 
    end
  end
end