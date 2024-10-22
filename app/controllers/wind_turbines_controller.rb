class WindTurbinesController < ApplicationController
  def index
    @wind_turbine_readings = WindTurbineReading.order(created_at: :desc).limit(10)
  end
end
