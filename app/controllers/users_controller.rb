class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    id = params[:id]
    @user = User.find(id)
    row_sql = <<-SQL
    select shops.shop_id, shops.name from users
    inner join evaluations on users.id = evaluations.user_id
    inner join photos on evaluations.photo_id = photos.id
    inner join shops on photos.shop_id = shops.shop_id
    where users.id = :user_id
    SQL
    args = [row_sql, user_id: @user.id]
    sql = ActiveRecord::Base.send(:sanitize_sql_array, args)
    @shops = ActiveRecord::Base.connection.select_all(sql)
    p @shops[0]
  end
end
