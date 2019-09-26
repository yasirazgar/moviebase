require 'test_helper'

class MovieSearchServiceTest < ActiveSupport::TestCase
  setup do
    @service = MovieSearchService.new
    @all_movies = all_movies
  end

  test "search-only_category_id" do
    assert_equal(
      [
        movies(:pulp_fiction).id,
        movies(:reservoir_dogs).id
      ],
      @service.search({category_id: Movie::Category::ACTION}).pluck(:id),
      "Should return movies with action category.")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  test "search-with_invalid_category_id" do
    assert_equal(
      @all_movies,
      @service.search({category_id: 6}).pluck(:id),
      "Should return all movies with invalid category.")

    assert_equal(
      @service.errors,
      [I18n.t('movie.search.error.category')],
      "Should return invalid category message.")
  end

  test "search-only_rating" do
    assert_equal(
      [
        movies(:inside_out).id,
        movies(:lion_king).id,
        movies(:god_father).id,
        movies(:snatch).id
      ],
      @service.search({rating: 3}).pluck(:id),
      "Should return movies with action category.")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  test "search-only_rating_zero" do
    assert_equal(
      [
        movies(:no_rating).id
      ],
      @service.search({rating: 0}).pluck(:id),
      "Should return movies with no rating")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  test "search-all-with_invalid_rating" do
    assert_equal(
      @all_movies,
      @service.search({rating: 6}).pluck(:id),
      "Should return all movies with invalid rating.")

    assert_equal(
      @service.errors,
      [I18n.t('movie.search.error.rating')],
      "Should return invalid rating message.")
  end

  test "search-only_term" do
    assert_equal(
      [movies(:pulp_fiction).id],
      @service.search({term: 'fiction'}).pluck(:id),
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
      [movies(:pulp_fiction).id],
      @service.search(terms).pluck(:id),
      "Should return all movies with matching terms.")

    assert_empty(@service.errors, "Should not have any errors.")
  end

  private

  def all_movies
    [
      movies(:pulp_fiction).id,
      movies(:reservoir_dogs).id,
      movies(:inside_out).id,
      movies(:lion_king).id,
      movies(:god_father).id,
      movies(:snatch).id,
      movies(:no_rating).id
    ]
  end

end
