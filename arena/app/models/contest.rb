class Contest < ActiveRecord::Base
  serialize :challenger
  serialize :defendant

  validates_presence_of :challenger, :defendant
end
