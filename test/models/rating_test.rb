require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  setup do
    @yasir = users(:yasir)
    @snatch = movies(:snatch)
  end
  test "validations_fails_without_rating" do

    assert(!Rating.new(user: @yasir, movie: @snatch).valid?,
      "Should not be valid if rating is missing.")
  end

  test "save_success_with_invalid_rating" do
    assert(!Rating.new(user: @yasir, movie: @snatch, rating: -8).valid?,
      "Should not be valid if rating is not an absolute value")
    assert(!Rating.new(user: @yasir, movie: @snatch, rating: 6).valid?,
      "Should not be valid if rating greater than 5.")
  end

  test "save_success_with_required_attrs" do
    assert(Rating.new(user: @yasir, movie: @snatch, rating: 5).valid?,
      "Should be valid required attrs are present.")
  end

  test "callback-update_movie_avg_rating" do
    snatch_rating = ratings(:yasir_snatch)

    snatch_rating.rating = 2
    snatch_rating.save

    assert_equal(3, @snatch.reload.avg_rating,
      "Should calculate and reset the average rating in movie")
  end
end
