#    Column   |              Type              | Collation | Nullable |               Default
# ------------+--------------------------------+-----------+----------+-------------------------------------
#  id         | bigint                         |           | not null | nextval('ratings_id_seq'::regclass)
#  user_id    | bigint                         |           | not null |
#  movie_id   | bigint                         |           | not null |
#  rating     | integer                        |           | not null |
#  created_at | timestamp(6) without time zone |           | not null |
#  updated_at | timestamp(6) without time zone |           | not null |
# Indexes:
#     "ratings_pkey" PRIMARY KEY, btree (id)
#     "index_ratings_on_movie_id" btree (movie_id)
#     "index_ratings_on_user_id" btree (user_id)

class Rating < ApplicationRecord
  MAX = 5
  MIN = 1

  belongs_to :user
  belongs_to :movie
  after_save :update_movie_avg_rating

  validates :rating, numericality: {
    greater_than_or_equal_to: MIN, less_than_or_equal_to: MAX,  only_integer: true }
  validates :movie, uniqueness: {
    scope: :user, message: I18n.t('rating.duplicate') }

  private

  def update_movie_avg_rating
    return unless saved_change_to_attribute? :rating

    movie.reset_avg_rating
  end
end
