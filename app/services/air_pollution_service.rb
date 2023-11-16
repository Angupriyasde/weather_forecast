class AirPollutionService
  API_KEY = ENV['API_KEY']
  CURRENT_AIR_POLLUTION_URL = ENV['CURRENT_AIR_POLLUTION_URL']
  HISTORY_AIR_POLLUTION_URL = ENV['HISTORY_AIR_POLLUTION_URL']

  def self.get_current_details(lat, lon)
    url = "#{CURRENT_AIR_POLLUTION_URL}?lat=#{lat}&lon=#{lon}&appid=#{API_KEY}"

    RestApiService.call(url)
  end

  def self.get_history(lat, lon)
    url = "#{HISTORY_AIR_POLLUTION_URL}?lat=#{lat}&lon=#{lon}&start=#{(Time.now - 10.days).to_i}&end=#{Time.now.to_i}&appid=#{API_KEY}"

    RestApiService.call(url)
  end
end