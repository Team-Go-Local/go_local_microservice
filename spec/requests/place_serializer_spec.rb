require 'spec_helper'

def app
  MapController
end

RSpec.describe 'PlaceSerializer' do
  it 'responds with the JSON requested' do
    VCR.use_cassette('place_search') do
      get '/api/v1/place_search?location=Casa-Bonita-Denver'
      # require 'pry'; binding.pry
      expect(last_response.status).to eq 200
      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to be_a Hash
      expect(response[:data][:attributes]).to have_key(:place_id)
      expect(response[:data][:attributes]).to have_key(:formatted_address)
      expect(response[:data][:attributes]).to have_key(:name)
      expect(response[:data][:attributes]).to have_key(:type)
    end
  end
end