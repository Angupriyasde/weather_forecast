require 'rest-client'
require 'json'

class RestApiService
    def self.call(url)
        begin
            puts "RestClient call----"
            response = RestClient.get(url)
            data = JSON.parse(response.body)
            puts "data:::#{data}"
            return data if data.present?
        rescue RestClient::ExceptionWithResponse => e
            raise "Error: #{e.response}"
        rescue RestClient::Exception, StandardError => e
            raise "Error: #{e.message}"
        end
    end
end