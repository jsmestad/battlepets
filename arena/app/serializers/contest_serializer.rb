class ContestSerializer < ActiveModel::Serializer
  attributes :id, :defendant, :challenger

  def id
    object.id.to_s
  end
end
