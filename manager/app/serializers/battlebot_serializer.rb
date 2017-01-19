class BattlebotSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :user

  def id
    object.id.to_s
  end
end
