class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :battlebots

  def id
    object.id.to_s
  end
end
