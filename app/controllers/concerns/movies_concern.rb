module MoviesConcern
  private

  def movie_fields(movie)
    fields = [
      movie.id, movie.title, movie.description, movie.avg_rating, movie.category_id, movie.category, movie.user_id,
    ]
    fields << movie.user_rating if movie.respond_to?(:user_rating)
    fields
  end

  def set_movie
    @movie = Movie.with_user_ratings(current_user).find(params[:id] || params[:movie_id])
  end

end
