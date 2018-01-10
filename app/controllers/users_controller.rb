class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def create
    user = User.new(user_params)
    if user.save
      render json: user.as_json(
        only: [:id, :username]
      )
    else
      render json: {errors: user.errors.messages} #, status: :bad_request
    end
  end

  def show
    render(
      status: :ok,
      json: @user.as_json(
        only: [:id, :username]
      )
    )
  end

  private

  def user_params
    params.permit(:username, :password)
  end

  def require_user
    @user = User.find_by(username: params[:username])
    if !@user
      render json: {
        errors: {
          user: ["User does not exist"]
        }
      }
    elsif @user.password != params[:password]
      render json: {
        errors: {
          password: ["Incorrect password"]
        }
      }
    end
  end
end
