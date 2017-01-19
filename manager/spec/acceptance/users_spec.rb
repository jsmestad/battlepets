require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Users' do
  header "Content-Type", "application/json"
  header "Accept", "application/json"

  get '/users' do
    context 'with no users existing' do
      example_request "Listing Users", documentation: false do
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
end
