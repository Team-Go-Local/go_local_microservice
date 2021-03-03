require 'spec_helper'

RSpec.describe 'place details request' do
  it 'responds with the JSON requested' do
    VCR.use_cassette('place_details') do
      get '/api/v1/place_details?place_id=ChIJFaqhMyt_bIcRMfeTGF4E8kM'

      expect(last_response.status).to eq 200
      expect(last_response.header['Content-Type']).to eq('application/json')
      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to be_a(Hash)
      check_hash_structure(response, :data, Hash)
      check_hash_structure(response[:data], :id, NilClass)
      check_hash_structure(response[:data], :type, String)
      check_hash_structure(response[:data], :attributes, Hash)
      check_hash_structure(response[:data][:attributes], :place_id, String)
      check_hash_structure(response[:data][:attributes], :formatted_address, String)
      check_hash_structure(response[:data][:attributes], :formatted_phone_number, String)
      check_hash_structure(response[:data][:attributes], :name, String)
      check_hash_structure(response[:data][:attributes], :website, String)
      check_hash_structure(response[:data][:attributes], :business_status, String)
      expect(response[:data][:attributes][:business_status]).to eq('OPERATIONAL')
      check_hash_structure(response[:data][:attributes], :opening_hours, Array)
      all_strings = response[:data][:attributes][:opening_hours].all? do |type|
        type.class == String
      end
      expect(all_strings).to be true
      check_hash_structure(response[:data][:attributes], :types, Array)
      all_strings = response[:data][:attributes][:types].all? { |type| type.class == String }
      expect(all_strings).to be true
      expect(response.keys).to match_array(%i[data])
      expect(response[:data].keys).to match_array(%i[id type attributes])
      expect(response[:data][:attributes].keys).to match_array(%i[place_id formatted_address formatted_phone_number name website types business_status opening_hours])
    end
  end

  it 'returns nil for hours if the business is not operatioal' do
    VCR.use_cassette('closed_business') do
      get '/api/v1/place_details?place_id=ChIJE7tYRySHa4cRSauU_fDROfk'

      expect(last_response.status).to eq 200
      expect(last_response.header['Content-Type']).to eq('application/json')
      response = JSON.parse(last_response.body, symbolize_names: true)

      check_hash_structure(response[:data][:attributes], :business_status, String)
      expect(response[:data][:attributes][:business_status]).to eq('CLOSED_TEMPORARILY')
      check_hash_structure(response[:data][:attributes], :opening_hours, NilClass)
    end
  end

  it 'handles a request with no place id' do
    VCR.use_cassette('missing_id') do
      get '/api/v1/place_details?place_id='

      expect(last_response.status).to eq(200)
      expect(last_response.header['Content-Type']).to eq('application/json')
      response = JSON.parse(last_response.body, symbolize_names: true)

      expect(response).to be_a Hash
      check_hash_structure(response, :data, NilClass)
    end
  end

  it 'returns an error if there is no response from Google' do
    stub_request(:get, "https://maps.googleapis.com/maps/api/place/details/json?fields=name,formatted_address,formatted_phone_number,opening_hours/weekday_text,website,types,business_status&key=AIzaSyBakD-sBtlGd3HupAxADRBfmg-gh73H0EQ&place_id=ChIJE7tYRySHa4cRSauU_fDROfk").to_return(status: 500)
    get '/api/v1/place_details?place_id=ChIJE7tYRySHa4cRSauU_fDROfk'

    expect(last_response.status).to eq(404)
    expect(last_response.header['Content-Type']).to eq('application/json')
    response = JSON.parse(last_response.body, symbolize_names: true)

    expect(response).to be_a Hash
    check_hash_structure(response, :errors, Array)
    expect(response[:errors][0]).to eq('the request could not be completed')
    expect(response[:errors][1]).to eq('external Places API unavailable')
  end
end
