class User < ApplicationRecord
  has_many :movies
  has_many :ratings

  validates :name, :email, presence: true
end
