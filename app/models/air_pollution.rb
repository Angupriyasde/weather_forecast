class AirPollution < ApplicationRecord
    belongs_to :location

    def self.average_air_quality_by_location_and_month
        select(
          'locations.name AS location_name',
          "TO_CHAR(to_timestamp(air_pollutions.unix_timestamp), 'YYYY-MM') AS month",
          'AVG(air_pollutions.air_quality_index) AS average_air_quality'
        )
        .joins(:location)
        .group('locations.name, month')
        .order('location_name, month')
    end

    def self.average_air_quality_by_location
        select(
          'locations.name AS location_name',
          'AVG(air_pollutions.air_quality_index) AS average_air_quality'
        )
        .joins(:location)
        .group('locations.name')
        .order('location_name')
    end


    def self.average_air_quality_per_state
        select(
          'locations.state AS state',
          'AVG(air_pollutions.air_quality_index) AS average_air_quality'
        )
        .joins(:location)
        .group('locations.state')
        .order('locations.state')
    end

end