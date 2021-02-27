class PlaceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :place_id, :formatted_address, :name, :type, :id
end
