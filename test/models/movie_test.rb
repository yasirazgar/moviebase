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

  test "category_map" do
    assert_equal(
      {
        Movie::Category::ACTION => [I18n.t('movie.category.action'), 2],
        Movie::Category::ANIMATION => [I18n.t('movie.category.animation'), 2],
        Movie::Category::COMEDY => [I18n.t('movie.category.comedy'), 2],
        Movie::Category::DRAMA => [I18n.t('movie.category.drama'), 1]
      }, Movie.category_map,
      "Should group and map based on categories.")
  end

  test "ratings_map" do
    assert_equal(
      {
        0 =>["Not Rated", 1],
        1 =>["1 Star", 0],
        2 =>["2 Stars", 0],
        3 =>["3 Stars", 4],
        4 =>["4 Stars", 1],
        5 =>["5 Stars", 1]
      },
      Movie.ratings_map,
      "Should group and map ratings.")
  end
end
