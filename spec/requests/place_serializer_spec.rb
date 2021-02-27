require 'spec_helper'

def app
  MapController
end

RSpec.describe 'PlaceSerializer' do
  it 'responds with the JSON requested' do
    VCR.use_cassette('place_search') do
      get '/api/v1/place_search?location=Casa-Bonita-Denver'
      require 'pry'; binding.pry
      expect(last_response).to be JSON
      expect(last_response.status).to eq 200
    end
  end
end