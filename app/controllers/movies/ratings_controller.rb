class Movies::RatingsController < ApplicationController
  include MoviesConcern

  before_action :set_movie, :set_rating

  def rate
    @rating ||= Rating.new(movie_id: @movie.id, user_id: current_user.id)
    @rating.rating = params[:rating]

    @rating.save

    data = {
      movie: movie_fields(@movie.reload)
    }
    render json: data
  end

  private

  def set_rating
    @rating = Rating.find_by(movie_id: params[:movie_id], user_id: current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rating_params
    params.require(:rating).permit(:user_id, :movie_id)
  end
end
