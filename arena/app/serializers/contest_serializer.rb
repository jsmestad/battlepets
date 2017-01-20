class ContestSerializer < ActiveModel::Serializer
  attributes :id, :defendant, :challenger, :winner

  def id
    object.id.to_s
  end

  def winner
    if winner = object.winner
      winner.to_s
    else
      nil
    end
  end
end
