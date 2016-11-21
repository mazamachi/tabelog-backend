class User < ActiveRecord::Base
  has_many :evaluations
end
