class FeelingsController < ApplicationController
  # before_action :require_movie, only: [:show]

  def index
    if params[:query]
      feelings = Feeling.where("name like ?", "%#{params[:query]}%")
      if feelings.length < 5
        feelings = Feeling.where(category: feelings[0].category)
      end
    else
      feelings = Feeling.all
    end

    render json: feelings.as_json(only: [:id, :name, :rating, :category])
    # render status: :ok, json: data
  end

  # def create
  #   movie = Movie.new(movie_params)
  #   if movie.save
  #     render json: {id: movie.id}
  #   else
  #     render json: {errors: movie.errors.messages}, status: :bad_request
  #   end
  # end
  #
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
  # def movie_params
  #   params.permit(:title, :overview, :inventory, :release_date)
  # end
  #
  # def require_movie
  #   @movie = Movie.find_by(title: params[:title])
  #   unless @movie
  #     render status: :not_found, json: { errors: { title: ["No movie with title #{params["title"]}"] } }
  #   end
  # end
end
