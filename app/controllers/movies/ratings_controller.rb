class Movies::RatingsController < ApplicationController
  before_filter :set_movie, :set_rating, except: :index

  def rate
    @rating ||= Rating.new(movie_id: @movie.id, user_id: current_user.id)
    @rating.rating = params[:rating]

    @rating.save

    data = {
      rating: @rating.rating,
      avg_rating: @movie.avg_rating,
      message: I18n.t('rating.rate')
    }
    render json: data
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_rating
    @rating = Rating.find_by(movie_id: params[:movie_id], user_id: current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rating_params
    params.require(:rating).permit(:user_id, :movie_id)
  end
end
