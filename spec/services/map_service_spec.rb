require 'spec_helper'

RSpec.describe MapService do
  describe 'place search' do
    it 'gets place info' do
      VCR.use_cassette('place_search') do
        query_string = 'casa-bonita-denver'
        place_info   = MapService.place_search(query_string)

        expect(place_info).to be_a Hash
        check_hash_structure(place_info, :status, String)
        expect(place_info[:status]).to eq('OK')
        check_hash_structure(place_info, :candidates, Array)
        expect(place_info[:candidates][0]).to be_a Hash

        place = place_info[:candidates][0]

        check_hash_structure(place, :formatted_address, String)
        check_hash_structure(place, :name, String)
        check_hash_structure(place, :place_id, String)
        check_hash_structure(place, :types, Array)
        all_strings = place[:types].all? { |type| type.class == String }
        expect(all_strings).to be true
        expect(place_info.keys).to match_array(%i[candidates status])
        expect(place_info[:candidates][0].keys).to match_array(%i[formatted_address name place_id types])
      end
    end

    it 'handles a request with no results', :vcr do
      VCR.use_cassette('no_results') do
        query_string = 'search-query-with-no-results'
        place_info   = MapService.place_search(query_string)

        expect(place_info).to be_a Hash
        check_hash_structure(place_info, :status, String)
        expect(place_info[:status]).to eq('ZERO_RESULTS')
        check_hash_structure(place_info, :candidates, Array)
        expect(place_info[:candidates]).to be_empty
      end
    end
  end

  describe 'place details' do
    it 'gets place info' do
      VCR.use_cassette('place_details') do
        place_id = 'ChIJFaqhMyt_bIcRMfeTGF4E8kM'
        place_info = MapService.place_details(place_id)

        expect(place_info).to be_a(Hash)
        check_hash_structure(place_info, :status, String)
        expect(place_info[:status]).to eq('OK')
        check_hash_structure(place_info, :result, Hash)
        check_hash_structure(place_info[:result], :formatted_address, String)
        check_hash_structure(place_info[:result], :formatted_phone_number, String)
        check_hash_structure(place_info[:result], :name, String)
        check_hash_structure(place_info[:result], :website, String)
        check_hash_structure(place_info[:result], :business_status, String)
        expect(place_info[:result][:business_status]).to eq('OPERATIONAL')
        check_hash_structure(place_info[:result], :opening_hours, Hash)
        check_hash_structure(place_info[:result][:opening_hours], :weekday_text, Array)
        all_strings = place_info[:result][:opening_hours][:weekday_text].all? do |type|
          type.class == String
        end
        expect(all_strings).to be true
        check_hash_structure(place_info[:result], :types, Array)
        all_strings = place_info[:result][:types].all? do |type|
          type.class == String
        end
        expect(all_strings).to be true
        expect(place_info.keys).to match_array(%i[html_attributions result status])
        expect(place_info[:result].keys).to match_array(%i[formatted_address formatted_phone_number name types website business_status opening_hours])
      end
    end

    it 'does not get hours if a business is not operational' do
      VCR.use_cassette('closed_business') do
        place_id = 'ChIJE7tYRySHa4cRSauU_fDROfk'
        place_info = MapService.place_details(place_id)

        expect(place_info).to be_a(Hash)
        check_hash_structure(place_info, :status, String)
        expect(place_info[:status]).to eq('OK')
        check_hash_structure(place_info[:result], :business_status, String)
        expect(place_info[:result][:business_status]).to eq('CLOSED_TEMPORARILY')
        expect(place_info[:result]).not_to have_key(:opening_hours)
        expect(place_info[:result].keys).to match_array(%i[formatted_address formatted_phone_number name types website business_status])
      end
    end
  end
end
