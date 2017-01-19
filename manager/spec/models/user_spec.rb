require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:email).of_type(:string) }

  it { is_expected.to validate_uniqueness_of(:email) }
end
