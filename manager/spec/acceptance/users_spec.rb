require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Users' do
  get '/users' do
    example_request "Listing Users" do
      expect(status).to eql(200)
    end
  end
end
