class WindTurbineReadingsController < ApplicationController
  def index
    @wind_turbine_readings = WindTurbineReading.where.not(actual_power_output: nil).order(created_at: :desc).limit(3)
  end

  def create

  end
end
