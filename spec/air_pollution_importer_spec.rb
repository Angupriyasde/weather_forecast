require 'rails_helper'

RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
end

RSpec.describe AirPollutionImporter do
  describe '.import' do
    let(:location1) { create(:location, latitude: 10, longitude: 20, name: "Mumbai", state: "Maharastra", country: "IN") }
    let(:location2) { create(:location, latitude: 30, longitude: 40, name: "Kanyakumari", state: "Tamilnadu", country: "IN") }
    let(:invalid_api_key) { 'your_invalid_api_key' }

    before do
      allow(Location).to receive(:all).and_return([location1, location2])

      # Stub the AirPollutionService to make a real request and return actual data
      allow(AirPollutionService).to receive(:get_current_details).with(10, 20).and_call_original
      allow(AirPollutionService).to receive(:get_current_details).with(30, 40).and_call_original
    end

    it 'imports air pollution data for each location' do
      VCR.use_cassette('air_pollution_service_response') do
        expect { AirPollutionImporter.import }.to change(AirPollution, :count)

        # Check if the records are created with the correct data
        expect(AirPollution.pluck(:location_id).uniq).to match_array([location1.id, location2.id])
      end
    end

    it 'handles missing or incomplete data from the API response' do
      VCR.use_cassette('air_pollution_service_response_missing_data') do
        # Stub the response to simulate missing data

        allow(AirPollutionService).to receive(:get_current_details).with(10, 20).and_return({ 'list' => [] })
        allow(AirPollutionService).to receive(:get_current_details).with(30, 40).and_return({ 'list' => [] })

        expect { AirPollutionImporter.import }.not_to change(AirPollution, :count)
      end
    end

    it 'handles API errors gracefully' do
      # Stub the AirPollutionService to raise an exception
      allow(AirPollutionService).to receive(:get_current_details).and_raise(StandardError, 'API error')

      expect { AirPollutionImporter.import }.not_to change(AirPollution, :count)
    end

    context 'when API key is invalid' do

        before do
          # Set an invalid API key as an environment variable for this context
          allow(ENV).to receive(:[]).with('API_KEY').and_return(invalid_api_key)
          allow(Location).to receive(:all).and_return([location1])

  
          # Stub the AirPollutionService to simulate an error response
          allow(AirPollutionService).to receive(:get_current_details).and_raise(StandardError, "Invalid API key")
        end
  
        it 'handles invalid API key gracefully' do
          VCR.use_cassette('air_pollution_service_response_invalid_api_key') do
            puts "api_key::#{ENV['API_KEY']}"
            expect { AirPollutionImporter.import }.not_to change(AirPollution, :count)
          end
        end
    end
  end
end
