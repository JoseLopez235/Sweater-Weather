class Api::V1::ImageController < ApplicationController
  def index
    image = ImageSearchFacade.image_search(params[:location])
    render json: ImageSerializer.new(image) 
  end
end