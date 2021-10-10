class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/forecast/zipCode/?format=application/json&zipCode=&date=2021-10-09&distance=0&API_KEY=6AFCC5D3-7C6C-4E55-9500-1DA727648388'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    return  @final_output = 'Error', @api_color = api_color if @output.empty? || !@output

    @final_output = @output[0]['AQI']
    @api_color = api_color
  end

  def api_color
    case @final_output
    when 'Error'
      @api_color = 'gray'
    when -100..50
      @api_color = 'green'
    when 51..100
      @api_color = 'yellow'
    when 101..150
      @api_color = 'orange'
    when 151..200
      @api_color = 'yellow'
    when 201..250
      @api_color = 'red'
    when 251..300
      @api_color = 'purple'
    else
      @api_color = 'maroon'
    end
  end
end
