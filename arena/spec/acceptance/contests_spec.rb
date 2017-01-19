require 'rails_helper'

resource 'Contests' do
  before do
    header "Content-Type", "application/json"
    header "Accept", "application/json"
  end

  get '/contests' do
    example_request "Listing Contests" do
      expect(status).to eql(200)

      response_hash = JSON.parse(response_body)
      expect(response_hash).to have_key('contests')
      expect(response_hash['contests']).to be_empty
    end
  end
end
