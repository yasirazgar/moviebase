class MovieSearchService
  attr_accessor :errors

  def initialize(user = nil)
    @user = user
    @errors = []
  end

  def search(params)
    rel = @user ? Movie.with_user_ratings(@user) : Movie.all
    rel = filter_by_term(rel, params[:term])
    rel = filter_by_category(rel, params[:category_id])
    filter_by_rating(rel, params[:rating])
  end

  private

  def filter_by_category(rel, category_id)
    return rel if category_id.blank?

    category_id = category_id.to_i

    unless Movie::CATEGORY_MAPPING.keys.include?(category_id)
      @errors << I18n.t('movie.search.error.category')

      return rel
    end

    rel.where(category_id: category_id)
  end

  def filter_by_term(rel, term)
    return rel if term.blank?

    rel.where("to_tsvector(title) @@ to_tsquery(?)", term)
  end

  def filter_by_rating(rel, rating)
    return rel if rating.blank?

    rating = rating.to_i
    if (rating == 0)
      return rel.where("avg_rating is NULL")
    end

    unless Rating::MIN.upto(Rating::MAX).include?(rating)
      @errors << I18n.t('movie.search.error.rating')

      return rel
    end

    rel = rel.where("avg_rating >= ? AND avg_rating < ?", rating, rating + 1)
  end

end
