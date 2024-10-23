Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end

  resources :wind_turbine_readings, only: [:index]
end
