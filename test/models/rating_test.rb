require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  setup do
    @one = users(:one)
    @movie_one = movies(:movie_one)
  end
  test "validations_fails_without_rating" do

    assert(!Rating.new(user: @one, movie: @movie_one).valid?,
      "Should not be valid if rating is missing.")
  end

  test "save_success_with_invalid_rating" do
    assert(!Rating.new(user: @one, movie: @movie_one, rating: -8).valid?,
      "Should not be valid if rating is not an absolute value")
    assert(!Rating.new(user: @one, movie: @movie_one, rating: 6).valid?,
      "Should not be valid if rating greater than 5.")
  end

  test "save_success_with_required_attrs" do
    assert(Rating.new(user: @one, movie: @movie_one, rating: 5).valid?,
      "Should be valid required attrs are present.")
  end

  test "callback-update_movie_avg_rating" do
    movie_one_rating = ratings(:one_movie_one)

    movie_one_rating.rating = 2
    movie_one_rating.save

    assert_equal(3, @movie_one.reload.avg_rating,
      "Should calculate and reset the average rating in movie")
  end
end
