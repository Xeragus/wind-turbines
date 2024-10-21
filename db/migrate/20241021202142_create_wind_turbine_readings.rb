class CreateWindTurbineReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :wind_turbine_readings do |t|
      t.datetime :time, null: false      # Timestamp of the reading
      t.float :temp_2m                   # Temperature at 2 meters
      t.float :relhum_2m                 # Relative humidity at 2 meters
      t.float :dp_2m                     # Dew point at 2 meters
      t.float :ws_10m                    # Wind speed at 10 meters
      t.float :ws_100m                   # Wind speed at 100 meters
      t.float :wd_10m                    # Wind direction at 10 meters
      t.float :wd_100m                   # Wind direction at 100 meters
      t.float :wg_10m                    # Wind gust at 10 meters
      t.float :actual_power_output
      t.float :forecasted_power_output

      t.timestamps
    end

    add_index :wind_turbine_readings, :time
    add_index :wind_turbine_readings, :actual_power_output
    add_index :wind_turbine_readings, :forecasted_power_output
  end
end
