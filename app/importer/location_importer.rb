class LocationImporter
   
    def self.import
        locations = ["chennai", "delhi", "hyderabad", "goa", "kerala", "kochin", "Kashmir","madurai", "trichy","Kanyakumari","Andra","Mumbai"]
        locations.each do |location|
            location_details = GeocodingService.geocode_location(location)

            next unless location_details
            create_locations(location_details)
        end  
    end

    private

    def self.create_locations(location_details)
        location_details.each do |detail|
            return if Location.find_by_name(detail["name"]).present?

            location = Location.create(name: detail["name"],
                                      latitude: detail["lat"],
                                      longitude: detail["lon"],
                                      state: detail["state"],
                                      country: detail["country"])
        end
    end
end