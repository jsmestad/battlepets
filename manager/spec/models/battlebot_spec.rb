require 'rails_helper'

RSpec.describe Battlebot, type: :model do
  it { is_expected.to belong_to(:user).inverse_of(:battlebots) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
end
