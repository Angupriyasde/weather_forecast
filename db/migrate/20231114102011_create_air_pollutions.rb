class CreateAirPollutions < ActiveRecord::Migration[7.1]
    def change
      create_table :air_pollutions do |t|
        t.integer :air_quality_index
        t.json    :pollutant_concentration
        t.integer :unix_timestamp, limit: 8
        t.references :location, foreign_key: true
  
        t.timestamps
      end
    end
end
  