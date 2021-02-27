require 'sinatra/base'
require './config/environment'
require './app/services/map_service'

class Place
  attr_reader :place_id, 
              :formatted_address, 
              :name, 
              :type,
              :id

  def initialize(result)
    @id = nil
    @place_id = result[:results][0][:place_id]
    @formatted_address = result[:results][0][:formatted_address]
    @name = result[:results][0][:name]
    @type = result[:results][0][:type]
  end
end