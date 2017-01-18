class ShopsController < ApplicationController
  def show
    user_id = params[:user_id]
    shop_id = params[:id]
    @user = User.find(user_id)
    @shop = Shop.find(shop_id)
    @useful  = Evaluation.where(user_id: user_id, score:  1).includes(:photo).where('photos.shop_id = ?', shop_id).references(:photos)
    @useless = Evaluation.where(user_id: user_id, score: -1).includes(:photo).where('photos.shop_id = ?', shop_id).references(:photos)
  end
end
