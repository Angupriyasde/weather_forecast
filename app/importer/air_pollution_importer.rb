class AirPollutionImporter

    def self.import
        locations = Location.all
        locations.each do |location|
            begin
                details = AirPollutionService.get_current_details(location.latitude, location.longitude)
                create_entry(details, location)
            rescue StandardError => e
                puts "Error importing air pollution data for #{location.name}: #{e.message}"
            end
        end
    end

    def self.import_history
        locations = Location.all
        locations.each do |location|
            begin
                details = AirPollutionService.get_history(location.latitude, location.longitude)
                create_entry(details, location)
            rescue StandardError => e
                puts "Error importing history of air pollution data for #{location.name}: #{e.message}"
            end
        end
    end

    private

    def self.create_entry(details, location)
        return unless details["list"]
        
        puts "details:::#{details["list"]}"
        details["list"].each do |detail|
            AirPollution.create(air_quality_index: detail["main"]["aqi"], 
                                pollutant_concentration: detail["components"],
                                unix_timestamp: detail["dt"],
                                location_id: location.id)
        end
    end
end