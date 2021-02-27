class MapController < Sinatra::Base
  before do
    content_type :json
  end

  get '/api/v1/place_search' do
    info = MapService.place_search(params[:location])
    place = Place.new(info[:candidates][0]) if info[:status] == 'OK'
    fields = { fields: { place: %i[place_id formatted_address name types] } }
    body PlaceSerializer.new(place, fields).serialized_json
  end

  get '/api/v1/place_details' do
    info = MapService.place_details(params[:place_id])
    place = Place.new(info[:result].merge(place_id: params[:place_id]))
    body PlaceSerializer.new(place).serialized_json
  end
end
