require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

   api = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"

    parsed_data = JSON.parse(open(api).read)
    
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]
  
  api = "https://api.darksky.net/forecast/58ee177735d87c2c8001fced47351f0a/#{@lat},#{@lng}"
  
    parsed_data = JSON.parse(open(api).read)
  
    @current_temperature = parsed_data.dig("currently", "temperature")

    @current_summary = parsed_data.dig("currently", "summary")

    @summary_of_next_sixty_minutes = parsed_data.dig("minutely", "summary")

    @summary_of_next_several_hours = parsed_data.dig("hourly", "summary")

    @summary_of_next_several_days = parsed_data.dig("daily", "summary")

    render("meteorologist/street_to_weather.html.erb")
  end
end
