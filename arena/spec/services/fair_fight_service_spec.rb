require 'rails_helper'

RSpec.describe FairFightService, type: :model do
  subject(:service_class) { described_class }
  let(:contest) { FactoryGirl.build(:contest) }

  it 'accepts a contest object' do
    obj = service_class.new(contest)
    expect(obj.contest).to eql(contest)
  end

  describe '#fight' do
    it 'sets a winner, only once' do
      obj = service_class.new(contest)
      expect(contest).to receive(:winner=).once.and_call_original
      2.times do
        obj.fight
      end
    end
  end
end
