# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.configure do
    ENV['API_KEY'] = 'd45605f341d647d9af5220962120f97c'
    ENV['GEOCODING_URL'] = 'http://api.openweathermap.org/geo/1.0/direct'
    ENV['CURRENT_AIR_POLLUTION_URL'] = 'http://api.openweathermap.org/data/2.5/air_pollution'
    ENV['HISTORY_AIR_POLLUTION_URL'] = 'http://api.openweathermap.org/data/2.5/air_pollution/history'
end
