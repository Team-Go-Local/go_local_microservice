class PlaceSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :place_id,
             :formatted_address,
             :name,
             :types,
             :formatted_phone_number,
             :website,
             :business_status,
             :opening_hours
end
