class HomeController < ApplicationController
  before_action :authenticate_user

  def show_weather_report
  end

  def fetch_weather_form_city_name
    if params[:city_name].present?
      url = "https://api.openweathermap.org/data/2.5/weather?q=#{params[:city_name]}&appid=#{openweathermap_api_key}"
      begin
        @response = JSON.parse(RestClient.get(url))
      rescue RestClient::ExceptionWithResponse => e
        @response = e.message
        case @response
        when "404 Not Found"
          @response = "city not exist"
        else
          @response = "Something went wrong."
        end
      end
    end
  end

  private

  def openweathermap_api_key
    OPEN_WEATHER_MAP_API_KEY
  end

  def authenticate_user
    unless current_user
      redirect_to login_path, alert: "please login to continue" and return
    end
  end
end
