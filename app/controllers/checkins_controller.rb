class CheckinsController < ApplicationController
  # before_action :require_movie, only: [:show]

  def index
    if params[:username]
      user = User.where(username: params[:username])[0].id
      users_checkins = Checkin.where(user_id: user)
      # puts users_checkins
    else
      users_checkins = Checkin.all
    end

    render json: users_checkins.as_json(only: [:id, :description, :created_at])


  end

  def create
    checkin = Checkin.new()
    data = params
    puts data
    checkin.user_id = User.where(username: data[:username])[0].id
    checkin.description = data[:description]
    # checkin.feelings << Feeling.find(data[:feelings].to_i)
    data[:feelings].each do |feeling|
      checkin.feelings << Feeling.find(feeling.to_i)
    end

    if checkin.save
      render json: checkin.as_json(only: [:id, :description, :user_id])
    else
      render json: {errors: checkin.errors.messages}, status: :bad_request
    end
  end

  # def show
  #   render(
  #     status: :ok,
  #     json: @movie.as_json(
  #       only: [:title, :overview, :release_date, :inventory],
  #       methods: [:available_inventory]
  #     )
  #   )
  # end

  # private
  #
  # def checkin_params
  #   params.permit(:description, :feelings, :user_id)
  # end
  #
  # def require_movie
  #   @movie = Movie.find_by(title: params[:title])
  #   unless @movie
  #     render status: :not_found, json: { errors: { title: ["No movie with title #{params["title"]}"] } }
  #   end
  # end
end
