class MapService
  class << self
    def place_search(query)
      response = conn.get('place/findplacefromtext/json') do |req|
        req.params[:input] = query
      end
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      @conn ||= Faraday.new('https://maps.googleapis.com/maps/api') do |req|
        req.params[:key] = ENV['MAP_API_KEY']
        req.params[:inputtype] = 'textquery'
        req.params[:fields] = 'place_id,formatted_address,name,types'
      end
    end
  end
end
