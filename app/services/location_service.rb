require 'rest-client'
require 'json'

class LocationService
  API_KEY = ENV['API_KEY']
  GEOCODING_URL = ENV['GEOCODING_URL']

  def self.get_details(location_name)
    url = "#{GEOCODING_URL}?q=#{location_name}&appid=#{API_KEY}"
    
    RestApiService.call(url)
  end
end