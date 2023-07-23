require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#fetch_weather_form_city_name' do
    context 'when city name is present' do
      it 'should make a request to the weather API' do
        expect(RestClient).to receive(:get).and_return('{}') # Empty JSON response for simplicity
        get :fetch_weather_form_city_name, params: { city_name: 'London' }
        expect(response).to be_successful
      end

      it 'should assign the API response to @response' do
        weather_response = { 'weather' => 'sunny', 'temperature' => 25 }
        expect(RestClient).to receive(:get).and_return(weather_response.to_json)

        get :fetch_weather_form_city_name, params: { city_name: 'London' }

        expect(assigns(:response)).to eq(weather_response)
      end
    end

    context 'when city name is not present' do
      it 'should not make a request to the weather API' do
        expect(RestClient).not_to receive(:get)
        get :fetch_weather_form_city_name
        expect(response).to be_successful
      end

      it 'should not assign anything to @response' do
        get :fetch_weather_form_city_name
        expect(assigns(:response)).to be_nil
      end
    end

    context 'when the weather API returns a 404 error' do
      it 'should handle the error and set an appropriate message in @response' do
        error_response = RestClient::NotFound.new
        expect(RestClient).to receive(:get).and_raise(error_response)

        get :fetch_weather_form_city_name, params: { city_name: 'InvalidCity' }

        expect(assigns(:response)).to eq('city not exist')
      end
    end

    context 'when the weather API returns an unexpected error' do
      it 'should handle the error and set a generic error message in @response' do
        error_response = RestClient::InternalServerError.new
        expect(RestClient).to receive(:get).and_raise(error_response)

        get :fetch_weather_form_city_name, params: { city_name: 'SomeCity' }

        expect(assigns(:response)).to eq('Something went wrong.')
      end
    end
  end

  describe '#show_weather_report' do
    it 'should render the show_weather_report template' do
      get :show_weather_report
      expect(response).to render_template(:show_weather_report)
    end
  end
end
