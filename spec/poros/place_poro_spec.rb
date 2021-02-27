require 'spec_helper'

RSpec.describe Place do
  before :each do
    @result = {
      formatted_address: "6715 W Colfax Ave, Lakewood, CO 80214, United States",
      name: "Casa Bonita",
      place_id: "ChIJE7tYRySHa4cRSauU_fDROfk",
      types: ["restaurant", "food", "point_of_interest", "establishment"]
    }

    @casa = Place.new(@result)
  end

  it 'instantiates with attributes' do
    expect(@casa).to be_a Place
    expect(@casa.place_id).to eq(@result[:place_id])
    expect(@casa.formatted_address).to eq(@result[:formatted_address])
    expect(@casa.name).to eq(@result[:name])
    expect(@casa.types).to eq(@result[:types])
  end
end
