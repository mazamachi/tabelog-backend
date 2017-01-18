class Api::PhotosController < ApplicationController
  def init
    p_params = permitted_params

    # 登録済みのスコアを取得
    sql = <<-SQL
      select * from evaluations
      where evaluations.user_id = :user_id
      inner join photos on photos.id = evaluations.photo_idZ
    SQL
    evaluations = Evaluation.find_by_sql([sql, user_id: p_params[:user_id], photo_urls: p_params[:photos].map{|h| h[:url]}])
    # evaluations = Evaluation.joins(:photo).where(photos: {shop_id: params[:shop_id]}, evaluations: permitted_params)

    # 未登録の写真を追加
    # sql = <<-SQL
    # select * from photos
    # where evaluations.user_id = :user_id
    # inner join photos on photos.photo_id in :photo_ids
    # SQL
    # evaluations = Evaluation.find_by_sql([sql, user_id: p_params[:user_id], photo_ids: p_params[:photos].map{|h| h[:id]})


    render json: evaluations.map{|e| {id: e.photo_id, score: e.score}}
  end

  private
  def permitted_params
    params.permit(photos: [:url, :id], :user_id)
  end

end
