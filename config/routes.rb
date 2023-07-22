Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :home, only: [] do
    collection do
      get :show_weather_report
      get :fetch_weather_form_city_name
    end
  end
end
