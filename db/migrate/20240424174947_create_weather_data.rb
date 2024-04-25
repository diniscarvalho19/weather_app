# frozen_string_literal: true

class CreateWeatherData < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_data do |t|
      t.float :latitude
      t.float :longitude
      t.date :date
      t.float :temperature
      t.float :humidity

      t.timestamps
    end
  end
end
