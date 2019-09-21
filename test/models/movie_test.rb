require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  setup do
    @yasir = users(:yasir)
    @snatch = movies(:snatch)
  end

  test "validations_fails_without_rating" do
    yasir = users(:yasir)

    assert(!Movie.new(user: yasir).valid?,
      "Should not be valid if title is missing.")
  end

  test "gets_saved_when_all_the_attributes_are_present" do
    yasir = users(:yasir)

    assert(Movie.new(user: yasir, title: 'Kill Bill').valid?,
      "Should be valid if all the attributes are present.")
  end

  test "dependent_destroy_ratings" do
    assert_difference('Movie.count', -1) do
      assert_difference('Rating.count', -3) do
        @snatch.destroy
      end
    end
  end

  test "reset_avg_rating" do
    original = @snatch.avg_rating

    @snatch.update_column(:avg_rating, 1.2)

    @snatch.reset_avg_rating

    assert_equal(original, @snatch.avg_rating, "Should reset to correct avg")
  end
end
