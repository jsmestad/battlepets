require 'rails_helper'

resource 'Battlebots' do
  before do
    header "Content-Type", "application/json"
    header "Accept", "application/json"
  end

  let(:existing_user) { FactoryGirl.create(:user) }

  get '/battlebots' do
    context 'with no battlebots existing' do
      example_request "Listing Battlebots", document: false do
        expect(status).to eql(200)
        response_hash = JSON.parse(response_body)
        expect(response_hash).to have_key('battlebots')
        expect(response_hash['battlebots']).to be_empty
      end
    end

    context 'with battlebots existing' do
      before do
        FactoryGirl.create_list(:battlebot, 3, :with_user)
      end

      example_request "Listing Battlebots" do
        expect(status).to eql(200)
        response_hash = JSON.parse(response_body)
        expect(response_hash).to have_key('battlebots')
        expect(response_hash['battlebots']).to_not be_empty
      end
    end
  end

  post '/battlebots' do
    parameter :name, 'The name for the battlebot', required: true, scope: 'battlebot'
    parameter :user_id, 'The ID of the user this battlebot should belong to', required: true, scope: 'battlebot'

    let(:name) { 'The Ultimatum' }
    let(:user_id) { existing_user.id.to_s }

    example_request 'Create a new battlebot' do
      expect(status).to eql(201)

      payload = JSON.parse(response_body)
      expect(payload).to have_key('battlebot')

      response_hash = payload['battlebot']
      expect(response_hash['id']).to match(/\d+/)
      expect(response_hash['name']).to eql(name)
      expect(response_hash['user']).to_not be_nil
      expect(response_hash['user']['id']).to eql(user_id)
    end

    context 'returning an error' do
      let!(:existing_battlebot) { FactoryGirl.create(:battlebot, user: existing_user) }

      let(:name) { existing_battlebot.name }

      example_request 'Creating a duplicate battlebot returns an error', document: false do
        expect(status).to eql(400)
        payload = JSON.parse(response_body)
        expect(payload['errors']).to_not be_empty
      end
    end

    context 'with bad parameters' do
      example 'Creating a battlebot with bad params', document: false do
        do_request(battlebot: {bad_param: 1112})
        expect(status).to eql(400)
      end
    end
  end
end
