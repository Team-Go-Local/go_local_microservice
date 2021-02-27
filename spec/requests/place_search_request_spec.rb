require 'spec_helper'

RSpec.describe 'PlaceSerializer' do
  it 'responds with the JSON requested' do
    VCR.use_cassette('place_search') do
      get '/api/v1/place_search?location=casa-bonita-denver'

      expect(last_response.status).to eq 200
      expect(last_response.header['Content-Type']).to eq('application/json')
      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to be_a Hash
      check_hash_structure(response, :data, Hash)
      check_hash_structure(response[:data], :id, NilClass)
      check_hash_structure(response[:data], :type, String)
      check_hash_structure(response[:data], :attributes, Hash)
      check_hash_structure(response[:data][:attributes], :place_id, String)
      check_hash_structure(response[:data][:attributes], :formatted_address, String)
      check_hash_structure(response[:data][:attributes], :name, String)
      check_hash_structure(response[:data][:attributes], :types, Array)
      all_strings = response[:data][:attributes][:types].all? { |type| type.class == String }
      expect(all_strings).to be true
      expect(response.keys).to match_array(%i[data])
      expect(response[:data].keys).to match_array(%i[id type attributes])
      expect(response[:data][:attributes].keys).to match_array(%i[place_id formatted_address name types])
    end
  end

  it 'returns an empty array if no results are found' do
    VCR.use_cassette('no_results') do
      get '/api/v1/place_search?location=search-query-with-no-results'

      expect(last_response.status).to eq(404)
      expect(last_response.header['Content-Type']).to eq('application/json')
      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to be_a Hash
      check_hash_structure(response, :data, Hash)
      expect(response[:data]).to be_empty
    end
  end
end
