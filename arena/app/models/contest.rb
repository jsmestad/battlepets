class Contest < ActiveRecord::Base
  serialize :challenger
  serialize :defendant

  validates_presence_of :challenger, :defendant
  validates_inclusion_of :winning_value, in: [-1, 0, 1]

  def who_won?
    case winning_value
    when 0
      :challenger
    when 1
      :defendant
    else
      nil
    end
  end

  def winner=(val)
    case val
    when :challenger
      challenger_wins
    when :defendant
      defendant_wins
    else
      false
    end
  end

  def defendant_wins
    self.winning_value = 1
  end

  def challenger_wins
    self.winning_value = 0
  end

  def winner
    if contestant = who_won?
      self.send(contestant)
    end
  end
end
