class UsersController < ApplicationController
  before_action :require_movie, only: [:show]

  def create
    user = User.new(user_params)
    if user.save
      render json: {id: user.id}
    else
      render json: {errors: user.errors.messages}, status: :bad_request
    end
  end

  def show
    render(
      status: :ok,
      json: @user.as_json(
        only: [:id, :username, :checkins]
      )
    )
  end

  private

  def user_params
    params.permit(:username, :password)
  end

  def require_movie
    @user = User.find_by(username: params[:id])
    unless @user
      render status: :not_found, json: { errors: { title: ["Not found"] } }
    end
  end
end
