require 'rails_helper'

resource 'Users' do
  before do
    header "Content-Type", "application/json"
    header "Accept", "application/json"
  end

  let(:existing_user) { FactoryGirl.create(:user, :with_battlebots, battlebots_count: 2) }

  get '/users' do
    context 'with no users existing' do
      example_request "Listing Users", document: false do
        expect(status).to eql(200)
        response_hash = JSON.parse(response_body)
        expect(response_hash).to have_key('users')
        expect(response_hash['users']).to be_empty
      end
    end

    context 'with users existing' do
      before do
        FactoryGirl.create_list(:user, 3)
      end

      example_request "Listing Users" do
        expect(status).to eql(200)
        response_hash = JSON.parse(response_body)
        expect(response_hash).to have_key('users')
        expect(response_hash['users']).to_not be_empty
      end
    end
  end

  get '/users/:id' do
    context 'when not found' do
      let(:id) { 'doesnt-exist' }

      example_request 'returns not found', document: false do
        expect(status).to eql(404)
      end
    end

    let(:id) { existing_user.id }

    example_request 'Fetching User Information' do
      expect(status).to eql(200)

      payload = JSON.parse(response_body)
      expect(payload).to have_key('user')

      response_hash = payload['user']
      expect(response_hash).to have_key('id')
      expect(response_hash).to have_key('email')
      expect(response_hash).to have_key('battlebots')
      expect(response_hash['battlebots'].length).to eql(2)
    end
  end

  post '/users' do
    parameter :email, 'Email address for the user', required: true, scope: 'user'

    let(:email) { 'my_user@gmail.example' }

    example_request 'Create a new user' do
      expect(status).to eql(201)

      payload = JSON.parse(response_body)
      expect(payload).to have_key('user')

      response_hash = payload['user']
      expect(response_hash['id']).to match(/\d+/)
      expect(response_hash['email']).to eql(email)
    end

    context 'returning an error' do

      let(:email) { existing_user.email }

      example_request 'Creating a duplicate user returns an error', document: false do
        expect(status).to eql(400)
        payload = JSON.parse(response_body)
        expect(payload['errors']).to_not be_empty
      end
    end

    context 'with bad parameters' do
      example 'Creating a user with bad params', document: false do
        do_request(user: {bad_param: 1112})
        expect(status).to eql(400)
      end
    end
  end
end
