require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  setup do
    @one = users(:one)
    @movie_one = movies(:movie_one)
  end

  test "validations_fails_without_rating" do
    one = users(:one)

    assert(!Movie.new(user: one).valid?,
      "Should not be valid if title is missing.")
  end

  test "gets_saved_when_all_the_attributes_are_present" do
    one = users(:one)

    assert(Movie.new(user: one, title: 'Kill Bill').valid?,
      "Should be valid if all the attributes are present.")
  end

  test "dependent_destroy_ratings" do
    assert_difference('Movie.count', -1) do
      assert_difference('Rating.count', -3) do
        @movie_one.destroy
      end
    end
  end

  test "reset_avg_rating" do
    original = @movie_one.avg_rating

    @movie_one.update_column(:avg_rating, 1.2)

    @movie_one.reset_avg_rating

    assert_equal(original, @movie_one.avg_rating, "Should reset to correct avg")
  end
end
