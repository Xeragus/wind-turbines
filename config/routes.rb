Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end

  resources :wind_turbines, only: [:index]
end
