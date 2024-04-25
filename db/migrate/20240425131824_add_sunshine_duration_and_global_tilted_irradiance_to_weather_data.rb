# frozen_string_literal: true

class AddSunshineDurationAndGlobalTiltedIrradianceToWeatherData < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_data, :sunshine_duration, :float
    add_column :weather_data, :global_tilted_irradiance, :float
  end
end
