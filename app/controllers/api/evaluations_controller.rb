class Api::EvaluationsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    p permitted_params
    @shop = Shop.find_by(shop_id: permitted_params[:shop][:shop_id])
    if @shop.nil?
      @shop = Shop.create(permitted_params[:shop])
    end
    @photo = Photo.find_or_create_by(permitted_params[:photo].merge(shop_id: @shop.id))

    @evaluation = Evaluation.find_or_initialize_by(user_id: permitted_params[:evaluation][:user_id], photo_id: @photo.id)
    @evaluation.update(score: permitted_params[:evaluation][:score])
    @evaluation.save

    score = Evaluation.where(photo_id: @photo.id).sum(:score)
    render json: {
      score: score,
    }
  end

  def update
    create
  end

  private
  def permitted_params
    params.permit(shop: [:shop_id, :name, :latitude, :longitude], photo: :url, evaluation: [:user_id, :score])
  end

end
