class Api::ShopsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
    evaluations = Evaluation.joins(:photo).where(photos: {shop_id: params[:id]}, evaluations: permitted_params)
    render json: evaluations.map{|e| {id: e.photo_id, score: e.score}}
  end

  def init
    p_params = init_permitted_params

    # 登録済みのスコアを取得
    # sql = <<-SQL
    #   select * from evaluations
    #   inner join photos on photos.id = evaluations.photo_id
    #   where evaluations.user_id = :user_id and photos.id in (:photo_ids)
    # SQL
    # evaluations = Evaluation.find_by_sql([sql, user_id: p_params[:user_id], photo_ids: p_params[:photos].map{|h| h["id"]}])
    evaluations = Evaluation.joins(:photo).where(evaluations: {user_id: p_params[:user_id]}, photos:{id: p_params[:photos].map{|h| h[:id]}})
    evaluated_photo_ids = evaluations.map(&:photo_id)

    # 未保存のShopを作成
    shop_params = p_params[:shop]
    unless Shop.find_by(shop_id: shop_params[:shop_id])
      Shop.create(shop_id: shop_params[:shop_id], name: shop_params[:name], latitude: shop_params[:latitude], longitude: shop_params[:longitude])
    end
    # 未保存のPhotoを作成
    existing_photo_ids = Photo.select("id").where(shop_id: params[:shop_id].to_i).all.map(&:id)
    p_params[:photos].select{|hash| !existing_photo_ids.include?(hash[:id])}.each do |hash|
      Photo.create(shop_id: params[:shop_id].to_i, id: hash[:id].to_i, url: hash[:url])
    end
    # 未評価の写真を初期化
    p_params[:photos].select{|hash| !evaluated_photo_ids.include?(hash[:id])}.each do |hash|
      evl = Evaluation.create(photo_id: hash[:id].to_i, user_id: p_params[:user_id].to_i, score: 0)
    end

    render json: evaluations.map{|e| {id: e.photo_id, score: e.score}}
  end

  private

  private
  def permitted_params
    params.permit(:user_id)
  end

  def init_permitted_params
    JSON.parse(request.body.read, {:symbolize_names => true})
  end

end
