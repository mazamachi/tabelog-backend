class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    id = params[:id]
    @user = User.find(id)
    sql = <<-SQL
      select * from shops
      where shops.shop_id in
      (
        select photos.shop_id from users
        inner join evaluations on users.id = evaluations.user_id
        inner join photos on evaluations.photo_id = photos.id
        where users.id = :user_id
      )
    SQL
    p @shops = Shop.find_by_sql([sql, user_id: @user.id])
  end
end
