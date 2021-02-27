require 'spec_helper'

RSpec.describe MapService do
  it 'place search' do
    VCR.use_cassette('place_search') do
      query_string = 'casa-bonita-denver'
      place_info   = MapService.place_search(query_string)

      expect(place_info).to be_a Hash
      check_hash_structure(place_info, :status, String)
      expect(place_info[:status]).to eq('OK')
      check_hash_structure(place_info, :results, Array)
      expect(place_info[:results][0]).to be_a Hash

      place = place_info[:results][0]

      check_hash_structure(place, :business_status, String)
      check_hash_structure(place, :formatted_address, String)
      check_hash_structure(place, :geometry, Hash)
      check_hash_structure(place, :icon, String)
      check_hash_structure(place, :name, String)
      check_hash_structure(place, :photos, Array)
      check_hash_structure(place, :place_id, String)
      check_hash_structure(place, :plus_code, Hash)
      check_hash_structure(place, :price_level, Integer)
      check_hash_structure(place, :rating, Float)
      check_hash_structure(place, :reference, String)
      check_hash_structure(place, :types, Array)
      check_hash_structure(place, :user_ratings_total, Integer)
    end
  end

  it 'handles a request with no results', :vcr do
    VCR.use_cassette('no_results') do
      query_string = 'search-query-with-no-results'
      place_info   = MapService.place_search(query_string)

      expect(place_info).to be_a Hash
      check_hash_structure(place_info, :status, String)
      expect(place_info[:status]).to eq('ZERO_RESULTS')
      check_hash_structure(place_info, :results, Array)
      expect(place_info[:results]).to be_empty
    end
  end
end
