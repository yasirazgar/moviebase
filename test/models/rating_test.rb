require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  setup do
    @user = users(:azgar)
    @duplicate_user = users(:yasir)
    @lion_king = movies(:lion_king)
    @rating = ratings(:yasir_lion_king)
  end
  test "validations_fails_without_rating" do
    assert(!Rating.new(user: @user, movie: @lion_king).valid?,
      "Should not be valid if rating is missing.")
  end

  test "validation_with_invalid_rating" do
    assert(!Rating.new(user: @user, movie: @lion_king, rating: -8).valid?,
      "Should not be valid if rating is not an absolute value")
    assert(!Rating.new(user: @user, movie: @lion_king, rating: 6).valid?,
      "Should not be valid if rating greater than 5.")
  end

  test "validation_duplicate_rating`_fails" do
    assert(!Rating.new(user: @duplicate_user, movie: @lion_king, rating: 4).valid?,
      "Should not be valid if rating is duplicate")
  end

  test "save_success_with_required_attrs" do
    assert(Rating.new(user: @user, movie: @lion_king, rating: 5).valid?,
      "Should be valid required attrs are present.")
  end

  test "callback-update_movie_avg_rating" do
    @rating.rating = 5
    @rating.save

    assert_equal(4.0, @lion_king.reload.avg_rating,
      "Should calculate and reset the average rating in movie")
  end
end
