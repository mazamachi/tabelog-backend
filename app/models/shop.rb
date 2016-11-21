class Shop < ActiveRecord::Base
  self.primary_key = :shop_id
  has_many :photos
end
