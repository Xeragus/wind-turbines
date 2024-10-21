namespace :import do
  desc 'Import wind turbine data from a CSV file'
  task wind_turbine_data: :environment do
    require 'csv'

    csv_file_path = 'alpha_turbine_data.csv' # Update with the actual path to your CSV

    CSV.foreach(csv_file_path, headers: true) do |row|
      WindTurbineReading.create!(
        time: row['Time'],                  # Ensure that your CSV headers match the column names
        temp_2m: row['Temp_2m'],
        relhum_2m: row['RelHum_2m'],
        dp_2m: row['DP_2m'],
        ws_10m: row['WS_10m'],
        ws_100m: row['WS_100m'],
        wd_10m: row['WD_10m'],
        wd_100m: row['WD_100m'],
        wg_10m: row['WG_10m'],
        actual_power_output: row['Power']
      )
    end

    puts 'Wind turbine data import complete!'
  end
end
