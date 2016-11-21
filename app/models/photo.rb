class Photo < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  has_many :evaluations
end
