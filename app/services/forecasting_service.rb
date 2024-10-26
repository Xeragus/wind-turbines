require 'net/http'
require 'json'

class ForecastingService
  class << self
    def forecast!(reading)
      url = URI("https://api.nixtla.io/forecast")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/json'
      request["authorization"] = 'Bearer nixtla-tok-BWOWNYGDsqpYozfhXh11gP3dKfOcF0I48Q12CqfedOg6JhofOEDt0WF5RJVxqNKWA55vgMpbVlQnx9jb'

      horizon = 1 # forecast for the next 1 hour

      request_body = {
        model: 'timegpt-1',
        freq: 'H',
        fh: horizon,
        y: WindTurbineReading.historical_time_series,
        x: WindTurbineReading.future_exogenous_variables,
        clean_ex_first: false,
        finetune_steps: 0,
        finetune_loss: 'default'
      }

      # Convert the Ruby hash to JSON
      request.body = request_body.to_json

      response = http.request(request)
      data = JSON.parse(response.body)
      Rails.logger.info("Response from TimeGPT: #{data}")
      reading.update!(forecasted_power_output: data['value'].first)
    end
  end
end