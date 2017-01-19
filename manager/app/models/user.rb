class User < ActiveRecord::Base
  validates_uniqueness_of :email

  has_many :battlebots, inverse_of: :user
end
