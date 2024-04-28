# frozen_string_literal: true

require "faraday"
require "json"

# Service to fetch weather api
class WeatherService
  def self.fetch_weather(latitude, longitude, start_date, end_date)
    url = "https://archive-api.open-meteo.com/v1/archive"
    params = { latitude:, longitude:, start_date:, end_date:,
               hourly: %w[temperature_2m relative_humidity_2m rain snowfall sunshine_duration global_tilted_irradiance weather_code wind_speed_10m] }
    conn = Faraday.new(url:)
    response = conn.get do |req|
      req.params = params
    end
    JSON.parse(response.body)["hourly"]
  end
end
