class AddRainAndSnowToWeatherData < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_data, :rain, :float
    add_column :weather_data, :snow, :float
  end
end
