class BattleJob < ActiveJob::Base
  queue_as :default

  def perform(contest)
    klass = "#{contest.style}Service".constantize
    fighter = klass.new(contest)
    fighter.fight
    contest.save
  end
end
