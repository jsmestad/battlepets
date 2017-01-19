class Battlebot < ActiveRecord::Base
  belongs_to :user, inverse_of: :battlebots

  validates :name, uniqueness: {scope: :user_id}, presence: true
end
