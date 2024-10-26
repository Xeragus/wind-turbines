class FruitsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :index]

  def index
    @fruits = Fruit.all
  end

  def create
    @fruit = Fruit.new(fruit_params)

    if @fruit.save
      # Broadcast the newly created fruit using Turbo Streams
      # @fruit.broadcast_append_to 'fruits'

      # Respond with JSON for the API request
      render json: @fruit, status: :created
    else
      # Respond with errors if the creation failed
      render json: @fruit.errors, status: :unprocessable_entity
    end
  end

  private

  def fruit_params
    params.require(:fruit).permit(:name, :color, :taste)
  end
end