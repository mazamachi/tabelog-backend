class Api::ShopsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
    evaluations = Evaluation.joins(:photo).where(photos: {shop_id: params[:id]}, evaluations: permitted_params)
    render json: evaluations.map{|e| {id: e.photo_id, score: e.score}}
  end

  private
  def permitted_params
    params.permit(:user_id)
  end

end
