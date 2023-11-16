class AirPollutionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    AirPollutionImporter.import
  end
end
