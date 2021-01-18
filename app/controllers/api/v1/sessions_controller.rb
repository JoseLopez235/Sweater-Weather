class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: {error: "Email or Password are Incorrect"}, status: 400
    end
  end
end