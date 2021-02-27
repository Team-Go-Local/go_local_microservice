class MapController < Sinatra::Base
  before do
    content_type :json
  end

  get '/api/v1/place_search' do
    info = MapService.place_search(params[:location])
    if info[:status] == 'OK'
      place = Place.new(info)
      body PlaceSerializer.new(place).serialized_json
    else
      body ({ data: {} }).to_json
      status :not_found
    end
  end
end
