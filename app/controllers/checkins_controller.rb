class CheckinsController < ApplicationController
  # before_action :require_movie, only: [:show]


  def create
    checkin = Checkin.new()
    data = checkin_params
    checkin.user_id = data[:user_id].to_i
    checkin.description = data[:description]
    checkin.feelings << Feeling.find(data[:feelings].to_i)
    # binding.pry
    # data[:feelings].each do |feeling|
    #   checkin.feelings << Feeling.find(feeling.to_i)
    # end

    if checkin.save
      render json: {id: checkin.id}
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

  private

  def checkin_params
    params.permit(:description, :feelings, :user_id)
  end
  #
  # def require_movie
  #   @movie = Movie.find_by(title: params[:title])
  #   unless @movie
  #     render status: :not_found, json: { errors: { title: ["No movie with title #{params["title"]}"] } }
  #   end
  # end
end
