class WindTurbineReading < ApplicationRecord
  after_create_commit { broadcast_append_to 'future_readings', target: 'future_readings', partial: 'wind_turbine_readings/future_reading', locals: { future_reading: self } }
end