class WindTurbineReading < ApplicationRecord
  after_create_commit do
    broadcast_append_to 'future_readings', target: 'future_readings',
                        partial: 'wind_turbine_readings/future_reading', locals: { future_reading: self }
  end

  def self.historical_time_series
    readings = where.not(actual_power_output: nil)

    historical_data = readings.each_with_object({}) do |reading, hash|
      hash[reading.time.strftime("%Y-%m-%d")] = reading.actual_power_output
    end

    historical_data
  end

  def self.future_exogenous_variables
    historical_data = self.all.each_with_object({}) do |reading, hash|
      hash[reading.time.strftime("%Y-%m-%d")] = [
        reading.temp_2m,
        reading.relhum_2m,
        reading.dp_2m,
        reading.ws_10m,
        reading.ws_100m,
        reading.wd_10m,
        reading.wd_100m,
        reading.wg_10m
      ]
    end

    historical_data
  end
end