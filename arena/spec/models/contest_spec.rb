require 'rails_helper'

RSpec.describe Contest, type: :model do
  subject(:contest) { described_class.new(challenger: challenger, defendant: defendant) }
  let(:challenger) { {id: '1', name: 'Challenger'} }
  let(:defendant) { {id: '2', name: 'Defendant'} }

  it { is_expected.to validate_presence_of(:challenger) }
  it { is_expected.to validate_presence_of(:defendant) }

  describe '#who_won?' do
    it { is_expected.to have_db_column(:winning_value).of_type(:integer) }
    it { is_expected.to validate_inclusion_of(:winning_value).in_array([-1, 0, 1]) }

    it 'says who won' do
      expect {
        contest.defendant_wins
      }.to change { contest.who_won? }.to(:defendant)

      expect {
        contest.challenger_wins
      }.to change { contest.who_won? }.to(:challenger)
    end
  end

  describe '#winner=' do
    it 'accepts either :defendant or :challenger' do
      expect(contest).to receive(:defendant_wins)
      contest.winner = :defendant

      expect(contest).to receive(:challenger_wins)
      contest.winner = :challenger
    end

    it 'rejects other values' do
      expect { contest.winner = :foobar }.to_not change { contest.who_won? }
    end
  end

  describe '#winner' do
    it 'returns the winners data' do
      expect {
        contest.defendant_wins
      }.to change { contest.winner }.to(defendant)

      expect {
        contest.challenger_wins
      }.to change { contest.winner }.to(challenger)
    end
  end

  describe 'style of contest' do
    it { is_expected.to validate_inclusion_of(:winning_value).in_array(['FairFight']) }
  end
end
