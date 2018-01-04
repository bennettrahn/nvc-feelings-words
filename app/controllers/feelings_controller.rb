class FeelingsController < ApplicationController
  def index
    feelings = Feeling.all
    render json: feelings.as_json(only: [:id, :name, :rating, :category])
  end
end
