class Place
  attr_reader :place_id,
              :formatted_address,
              :name,
              :types

  def initialize(result)
    @place_id = result[:place_id]
    @formatted_address = result[:formatted_address]
    @name = result[:name]
    @types = result[:types]
  end
end
