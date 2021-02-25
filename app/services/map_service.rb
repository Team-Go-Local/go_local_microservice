require 'faraday'
require './config/environment'

class MapService 
  class << self
    def place_search(query)
      response = conn.get('place/textsearch/json') do |req|
        req.params[:query] = query.downcase.gsub(' ', '-')
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      @conn ||= Faraday.new('https://maps.googleapis.com/maps/api') do |req|
        req.params[:key] = ENV['MAP_API_KEY']
      end
    end
  end
end