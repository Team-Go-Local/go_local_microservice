require 'spec_helper'

RSpec.describe 'place search request' do
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

  it 'returns null if no results are found' do
    VCR.use_cassette('no_results') do
      get '/api/v1/place_search?location=search-query-with-no-results'

      expect(last_response.status).to eq(200)
      expect(last_response.header['Content-Type']).to eq('application/json')
      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to be_a Hash
      check_hash_structure(response, :data, NilClass)
    end
  end

  it 'returns an error if there is no response from Google' do
    stub_request(:get, "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?fields=place_id,formatted_address,name,types&input=casa-bonita-denver&inputtype=textquery&key=AIzaSyBakD-sBtlGd3HupAxADRBfmg-gh73H0EQ").to_return(status: 500)

    get '/api/v1/place_search?location=casa-bonita-denver'

    expect(last_response.status).to eq(404)
    expect(last_response.header['Content-Type']).to eq('application/json')
    response = JSON.parse(last_response.body, symbolize_names: true)

    expect(response).to be_a Hash
    check_hash_structure(response, :errors, Array)
    expect(response[:errors][0]).to eq('the request could not be completed')
    expect(response[:errors][1]).to eq('external Places API unavailable')
  end
end
