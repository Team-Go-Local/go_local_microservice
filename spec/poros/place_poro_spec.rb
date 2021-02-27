require 'spec_helper'

RSpec.describe Place do
  let(:search_results) { {
    formatted_address: "6715 W Colfax Ave, Lakewood, CO 80214, United States",
    name: "Casa Bonita",
    place_id: "ChIJE7tYRySHa4cRSauU_fDROfk",
    types: ["restaurant", "food", "point_of_interest", "establishment"]
  } }

  let(:detailed_results) { {
    business_status: "OPERATIONAL",
    formatted_address: "100 W 14th Ave Pkwy, Denver, CO 80204, USA",
    formatted_phone_number: "(720) 865-5000",
    name: "Denver Art Museum",
    opening_hours:  {
      weekday_text: [
      ": nday: 10:00 AM – 5:00 PM",
        "Tuesday: 10:00 AM – 5:00 PM",
        "Wednesday: 10:00 AM – 5:00 PM",
        "Thursday: 10:00 AM – 5:00 PM",
        "Friday: 10:00 AM – 5:00 PM",
        "Saturday: 10:00 AM – 5:00 PM",
        "Sunday: 10:00 AM – 5:00 PM"
      ] },
    types: ["tourist_attraction", "museum", "point_of_interest", "establishment"],
    website: "https://denverartmuseum.org/",
    place_id: "ChIJFaqhMyt_bIcRMfeTGF4E8kM"}
  }

  it 'instantiates with attributes' do
    casa = Place.new(search_results)
    expect(casa).to be_a Place
    expect(casa).to have_attributes(
      place_id: search_results[:place_id],
      formatted_address: search_results[:formatted_address],
      name: search_results[:name],
      types: search_results[:types]
    )
  end

  it 'can be instantiated using results from the place details endpoint' do
    casa = Place.new(detailed_results)
    expect(casa).to be_a Place
    expect(casa).to have_attributes(
      business_status: detailed_results[:business_status],
      formatted_address: detailed_results[:formatted_address],
      formatted_phone_number: detailed_results[:formatted_phone_number],
      name: detailed_results[:name],
      opening_hours:  detailed_results[:opening_hours][:weekday_text],
      types: detailed_results[:types],
      website: detailed_results[:website],
      place_id: detailed_results[:place_id]
    )
  end

  it 'can be instantiated without opening hours' do
    results = detailed_results.reject {|k,v| k == :opening_hours }
    casa = Place.new(results)
    expect(casa).to be_a Place
    expect(casa.opening_hours).to eq(nil)
  end
end
