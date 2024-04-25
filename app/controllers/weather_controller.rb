# frozen_string_literal: true

require "date"

# Weather API Controller
#TODO
#edge cases
#error handling
class WeatherController < ApplicationController
  def index
    location = params[:location]
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    if location == "Lisbon"
      latitude = 38.7167
      longitude = -9.1333
    end

    result = Geocoder.search(location).first
    if result.present? && result.coordinates.present?
      latitude = result.latitude
      longitude = result.longitude
    else
      #return and send error back
    end

    weather_data_records = WeatherData.where(latitude: latitude, longitude: longitude, date: start_date..end_date)

    missing_dates = (start_date..end_date).to_a - weather_data_records.pluck(:date)

    if missing_dates.any?
      weather_data = WeatherApi.fetch_weather(latitude, longitude, missing_dates.first, missing_dates.last)
      create_weather_data(latitude, longitude, weather_data)
    end

    weather_data = {
      "time" => weather_data_records.pluck(:date),
      "temperature_2m" => weather_data_records.pluck(:temperature),
      "relative_humidity_2m" => weather_data_records.pluck(:humidity),
    }

    render json: weather_data
  end

  private

  def create_weather_data(latitude, longitude, weather_data)
    new_records = []
    weather_data["time"].each_with_index do |time, index|
      new_records << WeatherData.create!(
        latitude: latitude,
        longitude: longitude,
        date: Date.parse(time),
        temperature: weather_data["temperature_2m"][index],
        humidity: weather_data["relative_humidity_2m"][index],
      )
    end
    new_records
  end
end
