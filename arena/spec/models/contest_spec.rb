require 'rails_helper'

RSpec.describe Contest, type: :model do
  it { is_expected.to validate_presence_of(:challenger) }
  it { is_expected.to validate_presence_of(:defendant) }
end
