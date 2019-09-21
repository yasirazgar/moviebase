class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  after_save :update_movie_avg_rating

  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5,  only_integer: true }

  private

  def update_movie_avg_rating
    return unless saved_change_to_attribute? :rating

    movie.reset_avg_rating
  end
end
