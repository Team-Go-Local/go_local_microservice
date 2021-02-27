require './config/environment'
require './app/services/map_service'
require 'sinatra/base'

class MapController < Sinatra::Base
  get '/api/v1/place_search' do
    info = MapService.place_search(params[:location])
    place = Place.new(info)
    body PlaceSerializer.new(place).to_json
  end
end