class ErrorSerializer
  def self.serialized_json
    { errors: [
      'the request could not be completed',
      'external Places API unavailable'
    ] }.to_json
  end
end
