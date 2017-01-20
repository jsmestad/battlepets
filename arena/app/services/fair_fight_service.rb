class FairFightService
  attr_reader :contest

  def initialize(contest)
    @contest = contest
  end

  def fight
    return true if @contest.who_won?
    @contest.winner = [:challenger, :defendant].sample
  end

private

  def defendant
    @contest.defendant
  end

  def challenger
    @contest.challenger
  end

end
