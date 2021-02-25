require './config/environment'
require './app/services/map_service'
require 'sinatra/base'

class MapController < Sinatra::Base
  get '/api/v1/place_search' do
    MapService.place_search()
  end
end