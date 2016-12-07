class Api::UserController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def login
    user = User.find_by(permitted_params)
    if user.nil?
      render json: {
        status: "user_not_found"
      }, status: 400
    else
      render json: {
        userId: user.id
      }
    end
  end

  private
  def permitted_params
    params.require(:name)
    params.require(:password)
    params.permit(:name, :password)
  end

end
