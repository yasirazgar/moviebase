require 'test_helper'

class MovieSearchServiceTest < ActiveSupport::TestCase
  setup do
    @service = MovieSearchService.new
    @all_movies = all_movies
  end

  test "search-only_category_id" do
    assert_equal(
      [
        movies(:pulp_fiction),
        movies(:reservoir_dogs)
      ],
      @service.search({category_id: Movie::Category::ACTION}),
      "Should return movies with action category.")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  test "search-with_invalid_category_id" do
    assert_equal(
      @all_movies,
      @service.search({category_id: 6}),
      "Should return all movies with invalid category.")

    assert_equal(
      @service.errors,
      [I18n.t('movie.search.error.category')],
      "Should return invalid category message.")
  end

  test "search-only_rating" do
    assert_equal(
      [
        movies(:inside_out),
        movies(:lion_king),
        movies(:god_father),
        movies(:snatch)
      ],
      @service.search({rating: 3}),
      "Should return movies with action category.")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  test "search-only_rating_zero" do
    assert_equal(
      [
        movies(:no_rating)
      ],
      @service.search({rating: 0}),
      "Should return movies with no rating")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  test "search-all-with_invalid_rating" do
    assert_equal(
      @all_movies,
      @service.search({rating: 6}),
      "Should return all movies with invalid rating.")

    assert_equal(
      @service.errors,
      [I18n.t('movie.search.error.rating')],
      "Should return invalid rating message.")
  end

  test "search-only_term" do
    assert_equal(
      [movies(:pulp_fiction)],
      @service.search({term: 'fiction'}),
      "Should return all movies with term fiction.")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  test "search-all" do
    terms = {
      term: 'fiction',
      category: Movie::Category::ACTION,
      rating: 5
    }
    assert_equal(
      [movies(:pulp_fiction)],
      @service.search(terms),
      "Should return all movies with matching terms.")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  private

  def all_movies
    [
      movies(:pulp_fiction),
      movies(:reservoir_dogs),
      movies(:inside_out),
      movies(:lion_king),
      movies(:god_father),
      movies(:snatch),
      movies(:no_rating)
    ]
  end

end
