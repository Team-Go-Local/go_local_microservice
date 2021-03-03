class MapService
  class << self
    def place_search(query)
      response = conn.get('place/findplacefromtext/json') do |req|
        req.params[:input] = query
        req.params[:inputtype] = 'textquery'
        req.params[:fields] = 'place_id,formatted_address,name,types'
      end
      JSON.parse(response.body, symbolize_names: true) if response.status == 200
    end

    def place_details(place_id)
      response = conn.get('place/details/json') do |req|
        req.params[:place_id] = place_id
        req.params[:fields] = 'name,formatted_address,formatted_phone_number,' \
                              'opening_hours/weekday_text,website,types,business_status'
      end
      JSON.parse(response.body, symbolize_names: true) if response.status == 200
    end

    private

    def conn
      @conn ||= Faraday.new('https://maps.googleapis.com/maps/api') do |req|
        req.params[:key] = ENV['MAP_API_KEY']
      end
    end
  end
end
