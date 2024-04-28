# frozen_string_literal: true

require "date"

# Weather API Controller
class WeatherController < ApplicationController
  def index
    location_name = params[:location]
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    cached_location = Location.find_by(name: location_name)

    if cached_location
      latitude = cached_location.latitude
      longitude = cached_location.longitude
    else
      result = Geocoder.search(location_name).first
      if result.present? && result.coordinates.present?
        latitude = result.latitude
        longitude = result.longitude

        Location.create!(
          name: location_name,
          latitude:,
          longitude:,
        )
      else
        render json: { error: "Location not found" }, status: :not_found
        return
      end
    end

    weather_data_records = WeatherData.where(latitude:, longitude:, date: start_date..end_date).order(:date)

    missing_dates = (start_date..end_date).to_a - weather_data_records.pluck(:date)

    if missing_dates.any?
      weather_data = WeatherService.fetch_weather(latitude, longitude, missing_dates.first, missing_dates.last)
      create_weather_data(latitude, longitude, weather_data)
    end

    # Addition of Hours do Data
    # Pro: Prevent further hour calculations on the client side
    # Con: First time results can take a bit more time
    weather_data = {
      "time" => weather_data_records.pluck(:date),
      "temperature_2m" => weather_data_records.pluck(:temperature),
      "relative_humidity_2m" => weather_data_records.pluck(:humidity),
      "rain" => weather_data_records.pluck(:rain),
      "snowfall" => weather_data_records.pluck(:snow),
      "sunshine_duration" => weather_data_records.pluck(:sunshine_duration),
      "global_tilted_irradiance" => weather_data_records.pluck(:global_tilted_irradiance),
      "hour" => (0..23).to_a * weather_data_records.pluck(:date).uniq.size,
      "weather_code" => weather_data_records.pluck(:weather_code),
      "wind_speed_10m" => weather_data_records.pluck(:wind_speed_10m),
    }

    render json: weather_data
  end

  private

  def create_weather_data(latitude, longitude, weather_data)
    new_records = []
    weather_data["time"].each_with_index do |time, index|
      new_records << WeatherData.create!(
        latitude:,
        longitude:,
        hour: index % 24,
        date: Date.parse(time),
        temperature: weather_data["temperature_2m"][index],
        humidity: weather_data["relative_humidity_2m"][index],
        rain: weather_data["rain"][index],
        snow: weather_data["snowfall"][index],
        sunshine_duration: weather_data["sunshine_duration"][index],
        global_tilted_irradiance: weather_data["global_tilted_irradiance"][index],
        weather_code: weather_data["weather_code"][index],
        wind_speed_10m: weather_data["wind_speed_10m"][index],
      )
    end
    new_records
  end
end
