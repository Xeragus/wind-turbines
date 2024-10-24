Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end

  resources :wind_turbine_readings, only: [:index, :create] do
    post :forecast, on: :member
    post :add_actual_power_output, on: :member
  end
end
