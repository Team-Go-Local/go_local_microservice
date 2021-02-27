class MapController < Sinatra::Base
  before do
    content_type :json
  end

  get '/api/v1/place_search' do
    info = MapService.place_search(params[:location])
    place = Place.new(info[:candidates][0]) if info[:status] == 'OK'
    body PlaceSerializer.new(place).serialized_json
  end
end
