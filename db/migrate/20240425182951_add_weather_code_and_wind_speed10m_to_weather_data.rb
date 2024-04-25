class AddWeatherCodeAndWindSpeed10mToWeatherData < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_data, :weather_code, :string
    add_column :weather_data, :wind_speed_10m, :float
  end
end
