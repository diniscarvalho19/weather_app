# frozen_string_literal: true

class AddHourToWeatherData < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_data, :hour, :float
  end
end
