# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Clone the project

    `git clone https://github.com/Angupriyasde/weather_forecast.git`

* Install rails

    `gem install rails`

* Install gems

    `bundle install`

* Create & Migrate DB

    `rails db:create`

    `rails db:migrate`

* Start server

    `rails server`

* Importing data (Manually trigggering)

    `LocationImporter.import`

    `AirPollutionImporter.import` (To import current data)

    `AirPollutionImporter.import_history` (To import history)

* Import data using scheduler

    `whenever --update-crontab`

    `crontab -l` (To check if crontab is updated)

* Run test cases

    `bundle exec rspec`

* API to hit to get Average Air Quality index

    - Average air quality index per month per location

        `http://localhost:3000/air_pollutions/average_air_quality_index_per_month_per_location.json`

    - Average air quality index based on location

        `http://localhost:3000/air_pollutions/average_air_quality_by_location.json`

    - Average air quality index based on state

        `http://localhost:3000/air_pollutions/average_air_quality_per_state.json`

