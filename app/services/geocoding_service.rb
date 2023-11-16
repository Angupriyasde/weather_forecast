require 'rest-client'
require 'json'

class GeocodingService
  API_KEY = ENV['API_KEY']
  GEOCODING_URL = ENV['GEOCODING_URL']

  def self.geocode_location(location_name)
    url = "#{GEOCODING_URL}?q=#{location_name}&appid=#{API_KEY}"
    
    RestApiService.call(url)
  end
end