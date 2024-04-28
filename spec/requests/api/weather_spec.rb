require "swagger_helper"

RSpec.describe "api/weather", type: :request do
  path "/weather" do
    get "Fetch weather data" do
      tags "Weather"
      produces "application/json"
      parameter name: :location, in: :query, type: :string, required: true, description: "Location name"
      parameter name: :start_date, in: :query, type: :string, required: true, description: "Start date (YYYY-MM-DD)"
      parameter name: :end_date, in: :query, type: :string, required: true, description: "End date (YYYY-MM-DD)"

      response "200", "successful" do
        schema type: :object,
               properties: {
                 time: { type: :array, items: { type: :string } },
                 temperature_2m: { type: :array, items: { type: :float } },
                 relative_humidity_2m: { type: :array, items: { type: :float } },
                 rain: { type: :array, items: { type: :float } },
                 snowfall: { type: :array, items: { type: :float } },
                 sunshine_duration: { type: :array, items: { type: :integer } },
                 hour: { type: :array, items: { type: :integer } },
                 global_tilted_irradiance: { type: :array, items: { type: :float } },
                 weather_code: { type: :array, items: { type: :integer } },
                 wind_speed_10m: { type: :array, items: { type: :float } },
               }

        run_test!
      end

      response "404", "not found" do
        run_test!
      end
    end
  end
end
