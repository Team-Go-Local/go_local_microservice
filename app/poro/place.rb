class Place
  attr_reader :place_id,
              :formatted_address,
              :name,
              :types

  def initialize(result)
    @place_id = result[:results][0][:place_id]
    @formatted_address = result[:results][0][:formatted_address]
    @name = result[:results][0][:name]
    @types = result[:results][0][:types]
  end
end
