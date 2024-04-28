Weather Archive API
==================

Introduction
------------

This project is a weather API controller built using Ruby on Rails. It provides endpoints to fetch weather data for specific locations and time periods from an external weather API. Additionally, it handles caching of location data and missing weather records. CORS header configured to accept requests comming from React App. Specifically localhost for development and url of React App in deployed using Netlify for production. This React App already deployed can be accessed [here](https://weather-archive-xp.netlify.app/).

This Rails App is live with Heroku and can be found [here](https://sleepy-river-65200-79c7ffcf377b.herokuapp.com/).

Features
--------
-   Fetch weather data for a specific location and time period.
-   Caching of location data to minimize external API calls.
-   Handling missing weather records by fetching from the external API.
-   Provides weather data in JSON format.
-   Database for development and database for production.
-   Swagger documentation of API.

Installation and Setup
----------------------

1.  Clone the repository to your local machine.
2.  Ensure you have Ruby and Rails installed.
3.  Install dependencies by running `bundle install`.
4.  Set up the database by running `rails db:create` followed by `rails db:migrate`.
5.  Start the Rails server with `rails server`.

Usage
-----

### Endpoint




`GET /weather?location=<location>&start_date=<start_date>&end_date=<end_date> `

-   `location`: The name of the location for which weather data is requested.
-   `start_date`: The start date of the time period for which weather data is requested (format: YYYY-MM-DD).
-   `end_date`: The end date of the time period for which weather data is requested (format: YYYY-MM-DD).

### Example




`GET /weather?location=New+York&start_date=2024-04-01&end_date=2024-04-10`

Dependencies
------------

-   Ruby on Rails
-   Faraday gem for making HTTP requests
-   Geocoder gem for geocoding location names




