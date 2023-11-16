class AirPollutionsController < ApplicationController
    def average_air_quality_index_per_month_per_location
        render :json => AirPollution.average_air_quality_by_location_and_month, :status => 200
    end

    def average_air_quality_by_location
        render :json => AirPollution.average_air_quality_by_location, :status => 200
    end

    def average_air_quality_per_state
        render :json => AirPollution.average_air_quality_per_state, :status => 200
    end

end
