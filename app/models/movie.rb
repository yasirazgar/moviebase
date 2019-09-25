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
  # keep this in sync with /app/javascript/packs/constants.js
  module Category
    ACTION = 1
    DRAMA = 2
    COMEDY = 3
    ANIMATION = 4
  end
  CATEGORY_MAPPING = {
    Category::ACTION => 'action',
    Category::ANIMATION => 'animation',
    Category::COMEDY => 'comedy',
    Category::DRAMA => 'drama'
  }.freeze

  validates :title, :category_id, presence: true

  belongs_to :user

  has_many :ratings, dependent: :destroy

  def self.ratings_map
    hash = {
      0 => [I18n.t('movie.stars.not_rated')],
      1 => [I18n.t('movie.stars.one'), 0]
    }
    hash = (Rating::MIN.upto(Rating::MAX).to_a - [1]).inject(hash){|h, i|
      h[i] = [I18n.t('movie.stars.multiple', count: i), 0]
      h
    }
    # stars = Movie.select("count(movies.*) as star_count, FLOOR(avg_rating)::integer as star").group("star")
    stars = Movie
              .select("count(movies.*) as star_count, FLOOR(avg_rating)::integer as star")
              .group("star")

    stars.inject(hash) do |ha, star|
      ha[star["star"].to_i][1] = star["star_count"]
      ha
    end
  end

  def category
    I18n.t("movie.category.#{CATEGORY_MAPPING[category_id]}")
  end

  def self.category_map
    cat_map = Movie.select("count(*) as movies_count, category_id").order(:category_id).group(:category_id)

    hash = CATEGORY_MAPPING.inject({}) do |h, (cat_id, cat)|
      h[cat_id] = [I18n.t("movie.category.#{cat}"), 0]
      h
    end

    cat_map.each{ |h| hash[h['category_id']][1] = h['movies_count'] }

    hash
  end

  def reset_avg_rating
    update_column(:avg_rating, ratings.average(:rating).to_f.round(1))
  end
end
