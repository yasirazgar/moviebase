require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  setup do
    @yasir = users(:yasir)
    @snatch = movies(:snatch)
    @required_params = {
      user: @yasir,
      title: 'Kill Bill',
      category_id: Movie::Category::ACTION
    }
  end

  test "gets_saved_when_all_the_attributes_are_present" do
    assert(Movie.new(@required_params).valid?,
      "Should be valid if all the attributes are present.")
  end

  test "validations" do
    @required_params.keys.each do |param|
      assert(!Movie.new(@required_params.except(param)).valid?,
        "Should not be valid if #{param} is missing.")
    end
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

  test "category" do
    Movie::Category.constants.each do |category|
      assert_equal(
        [
          movies(:reservoir_dogs).category,
          movies(:god_father).category,
          movies(:inside_out).category,
          movies(:snatch).category
        ],
        [
          I18n.t('movie.category.action'),
          I18n.t('movie.category.drama'),
          I18n.t('movie.category.animation'),
          I18n.t('movie.category.comedy')
        ],
        "Should correctly map all the categories")
    end
  end
end
