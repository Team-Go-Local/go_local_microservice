class PlaceSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :place_id, :formatted_address, :name, :types
end
