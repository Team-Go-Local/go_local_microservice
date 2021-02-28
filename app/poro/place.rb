class Place
  attr_reader :place_id,
              :formatted_address,
              :name,
              :types,
              :formatted_phone_number,
              :website,
              :business_status,
              :opening_hours

  def initialize(result)
    @place_id = result[:place_id]
    @formatted_address = result[:formatted_address]
    @name = result[:name]
    @types = result[:types]
    @formatted_phone_number = result[:formatted_phone_number]
    @website = result[:website]
    @business_status = result[:business_status]
    @opening_hours = result[:opening_hours][:weekday_text] if result[:opening_hours]
  end
end
