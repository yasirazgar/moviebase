class Movie < ApplicationRecord
  module Category
    Action = 1
    Drama = 2
    Comedy = 3
    Animation = 4
  end

  validates :title, presence: true

  belongs_to :user
  has_many :ratings, dependent: :destroy

  def reset_avg_rating
    update_column(:avg_rating, ratings.average(:rating).to_f.round(1))
  end
end
