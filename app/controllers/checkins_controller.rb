class CheckinsController < ApplicationController
  # before_action :require_movie, only: [:show]

  def index
    day_averages = {}
    days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']


    if params[:username]
      user = User.where(username: params[:username])[0]
      users_checkins = user.checkins.where(created_at: 1.week.ago..Time.now).order(:created_at)

      users_checkins.each do |checkin|
        index = checkin.created_at.wday
        feelingTotal = 0;
        checkin.feelings.each do |feeling|
          feelingTotal += feeling.rating.to_f
        end
        feelingAvg = feelingTotal / checkin.feelings.length;

        if day_averages[days[index]]
          day_averages[days[index]] = ((day_averages[days[index]] + feelingAvg) / 2)
        else
          day_averages[days[index]] = feelingAvg
        end
      end
      # binding.pry
      # puts users_checkins
    else
      users_checkins = Checkin.all
    end

    users_checkins = users_checkins.reverse
    # render json: post, include: ['comments'].
    # render json: {errors: checkin.errors.messages}, status: :bad_request

    render json: {
      all_checkins: users_checkins.as_json(only: [:id, :description, :created_at], include: [:feelings]),
      day_averages: day_averages.to_a
    }
  end

  def categories
    categories = {}
    if params[:username]
      user = User.where(username: params[:username])[0]
      users_checkins = user.checkins.where(created_at: 1.week.ago..Time.now).order(:created_at)

      users_checkins.each do |checkin|
        checkin.feelings.each do |feeling|
          if categories[feeling.category.name]
            categories[feeling.category.name] += 1
          else
            categories[feeling.category.name] = 1
          end
        end
      end

      total = categories.values.inject(:+)

      categories.each do |category, val|
        percent = ((val.to_f / total) * 100).to_i
        if percent <= 5
          categories.delete(category)
        else
          categories[category] = percent
        end
      end

      categories["other"] = (100 - categories.values.inject(:+))
    end

    sorted = categories.sort_by {|k, v| -v }

    render json: sorted

  end
  # def index
  #   if params[:query]
  #     feelings = Feeling.where("name like ?", "%#{params[:query]}%")
  #     if feelings.length == 0
  #       feelings = []
  #     elsif feelings.length <= 2
  #       feelings = Feeling.where(category: feelings[0].category)
  #     end
  #   else
  #     feelings = Feeling.all
  #   end
  #
  #   render json: feelings.as_json(only: [:id, :name, :rating, :category])
  #   # render status: :ok, json: data
  # end

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
