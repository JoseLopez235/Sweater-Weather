class Api::V1::MunchiesController < ApplicationController
  def index
    munchies = MunchiesSearchFacade.find_munchies(params[:start], params[:destination], params[:food])
    render json: MunchieSerializer.new(munchies)
  end
end