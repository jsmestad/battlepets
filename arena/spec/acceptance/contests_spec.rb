require 'rails_helper'

resource 'Contests' do
  before do
    header "Content-Type", "application/json"
    header "Accept", "application/json"
  end

  let(:pending_contest) { FactoryGirl.create(:contest) }
  let(:finished_contest) do
    FactoryGirl.create(:contest).tap do |c|
      c.defendant_wins
      c.save
    end
  end

  get '/contests' do
    example_request "Listing Contests" do
      expect(status).to eql(200)

      response_hash = JSON.parse(response_body)
      expect(response_hash).to have_key('contests')
      expect(response_hash['contests']).to be_empty
    end
  end

  get '/contests/:id' do
    context 'when not found' do
      let(:id) { 'doesnt-exist' }

      example_request 'returns not found', document: false do
        expect(status).to eql(404)
      end
    end

    let(:id) { pending_contest.id }

    example_request 'Fetching an Pending Contest' do
      expect(status).to eql(200)

      payload = JSON.parse(response_body)
      expect(payload).to have_key('contest')

      response_hash = payload['contest']
      expect(response_hash['id']).to match(/\d+/)
      expect(response_hash).to have_key('winner')
      expect(response_hash['winner']).to eql(nil)
    end

    describe 'finished contest' do

      let(:id) { finished_contest.id }

      example_request 'Fetching an Completed Contest' do
        expect(status).to eql(200)

        payload = JSON.parse(response_body)
        expect(payload).to have_key('contest')

        response_hash = payload['contest']
        expect(response_hash['id']).to match(/\d+/)
        expect(response_hash).to have_key('winner')
        expect(response_hash['winner']).to eql('defendant')
      end
    end
  end

  post '/contests' do

    parameter :style, "The style of contest. Available contests are 'FairFight'", required: true, scope: :contest

    with_options scope: [:contest, :challenger], required: true do
      parameter :id, 'The name for the challenging battlebot', method: :challenger_id
      parameter :name, 'The name for the challenging battlebot', method: :challenger_name
    end

    with_options scope: [:contest, :defendant], required: true do
      parameter :id, 'The name for the defending battlebot', method: :defendant_id
      parameter :name, 'The name for the defending battlebot', method: :defendant_name
    end

    let(:style) { 'FairFight' }

    let(:challenger_id) { '1' }
    let(:challenger_name) { 'The Ultimatum' }

    let(:defendant_id) { '2' }
    let(:defendant_name) { 'Defender of Worlds' }

    example 'Create a new contest' do
      expect(BattleJob).to receive(:perform_later)
      do_request
      expect(status).to eql(201)

      payload = JSON.parse(response_body)
      expect(payload).to have_key('contest')

      response_hash = payload['contest']
      expect(response_hash['id']).to match(/\d+/)
      expect(response_hash).to have_key('winner')
      expect(response_hash['winner']).to eql(nil)
      expect(response_hash['style']).to eql('FairFight')
      expect(response_hash['defendant']['id']).to eql(defendant_id)
      expect(response_hash['defendant']['name']).to eql(defendant_name)

      expect(response_hash['challenger']['id']).to eql(challenger_id)
      expect(response_hash['challenger']['name']).to eql(challenger_name)
    end

    context 'with bad parameters' do
      example 'Creating a contest with bad params', document: false do
        do_request(contest: {bad_param: 1112})
        expect(status).to eql(400)
      end
    end
  end
end
