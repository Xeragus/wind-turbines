class WindTurbineReadingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :add_actual_power_output]

  def index
    @wind_turbine_readings = WindTurbineReading.where.not(actual_power_output: nil).order(created_at: :asc).last(3)
    @forecasted_readings = WindTurbineReading.where(actual_power_output: nil)
                                             .where.not(forecasted_power_output: nil)
                                             .order(created_at: :asc)
    @future_readings = WindTurbineReading.where(actual_power_output: nil, forecasted_power_output: nil)
                                         .order(created_at: :asc)
  end

  def create
    @wind_turbine_reading = WindTurbineReading.new(wind_turbine_reading_params)

    if @wind_turbine_reading.save
      render json: { message: 'Wind turbine reading successfully created', reading: @wind_turbine_reading }, status: :created
    else
      render json: { errors: @wind_turbine_reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def forecast
    reading = WindTurbineReading.find(params[:id])
    reading.forecasted_power_output = 4

    if reading.save
      render json: { message: 'Wind turbine reading successfully updated', reading: }, status: :created
    else
      render json: { errors: reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def add_actual_power_output
    reading = WindTurbineReading.find(params[:id])
    reading.actual_power_output = params[:actual_power_output]

    if reading.save
      render json: { message: 'Wind turbine reading successfully updated', reading: }, status: :created
    else
      render json: { errors: reading.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def wind_turbine_reading_params
    params.require('wind_turbine_reading').permit(
      :time, :temp_2m, :relhum_2m, :dp_2m, :ws_10m, :ws_100m, :wd_10m,
      :wd_100m, :wg_10m, :actual_power_output, :forecasted_power_output
    )
  end
end
