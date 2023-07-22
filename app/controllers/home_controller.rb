class HomeController < ApplicationController
  # before_action :authenticate_user

  def show_weather_report
  end

  def fetch_weather_form_city_name
    if params[:city_name].present?
      url = "https://api.openweathermap.org/data/2.5/weather?q=#{params[:city_name]}&appid=#{openweathermap_api_key}"
      begin
        @response = RestClient.get(url)
      rescue RestClient::ExceptionWithResponse => e
        response = e.response
      end
    end
  end

  private

  def openweathermap_api_key
    'secret-key'
  end
end
