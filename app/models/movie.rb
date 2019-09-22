#    Column    |              Type              | Collation | Nullable |              Default
# -------------+--------------------------------+-----------+----------+------------------------------------
#  id          | bigint                         |           | not null | nextval('movies_id_seq'::regclass)
#  user_id     | bigint                         |           | not null |
#  title       | character varying              |           |          |
#  description | text                           |           |          |
#  category_id | integer                        |           |          |
#  avg_rating  | double precision               |           |          |
#  created_at  | timestamp(6) without time zone |           | not null |
#  updated_at  | timestamp(6) without time zone |           | not null |
# Indexes:
#     "movies_pkey" PRIMARY KEY, btree (id)
#     "index_movies_on_user_id" btree (user_id)

class Movie < ApplicationRecord
  module Category
    ACTION = 1
    DRAMA = 2
    COMEDY = 3
    ANIMATION = 4
  end
  CATEGORY_MAPPING = {
    Category::ACTION => 'action',
    Category::DRAMA => 'drama',
    Category::COMEDY => 'comedy',
    Category::ANIMATION => 'animation'
  }.freeze

  def category
    I18n.t("movie.category.#{CATEGORY_MAPPING[category_id]}")
  end

  validates :title, presence: true

  belongs_to :user
  has_many :ratings, dependent: :destroy

  def reset_avg_rating
    update_column(:avg_rating, ratings.average(:rating).to_f.round(1))
  end
end
