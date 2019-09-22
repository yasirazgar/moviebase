require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:snatch)
    @user = users(:azgar)
    @unauthorized_user = users(:yasir)
  end

  test "should get index" do
    get movies_url(limit: 3)

    assert_response :success

    movies = [
      movies(:pulp_fiction),
      movies(:reservoir_dogs),
      movies(:inside_out)
    ]
    assert_equal(
      expected_movies_response(movies),
      json_response['movies'],
      "Should return all movies")

    assert_pagination_headers(7)
  end

  test "search" do
    params = {
      category_id: Movie::Category::ACTION,
      rating: 4,
      term: 'dogs'
    }
    movie = movies(:reservoir_dogs)

    get(search_movies_url(params))

    assert_response :success

    assert_equal(
      expected_movies_response([movie]),
      json_response['movies'],
      "Should return the movie according to search terms.")

    assert_pagination_headers(1)
  end

  test "search-only_action" do
    params = {
      category_id: Movie::Category::ANIMATION,
      limit: 1
    }
    movie = movies(:inside_out)

    get(search_movies_url(params))

    assert_response :success

    assert_equal(
      expected_movies_response([movie]),
      json_response['movies'],
      "Should return the movies with action category with limit 1.")

    assert_pagination_headers(2)
  end

  test "should create movie" do
    params = {
      movie: {
        category_id: Movie::Category::ACTION,
        title: @movie.title,
        description: 'Movie Description'
      }
    }
    assert_difference('Movie.count') do
      json_post(movies_url, @user, params)
    end
    assert_response :success

    assert_not_nil(json_response['movie']['id'], 'Should set movie id')
    assert_equal(
      params[:movie][:title],
      json_response['movie']['title'],
      'Should set movie title')
    assert_equal(
      params[:movie][:description],
      json_response['movie']['description'],
      'Should set movie title')
  end

  test "update movie unauthorized_user_fails" do
    params = {
      movie: {
        category_id: Movie::Category::ANIMATION,
        title: 'New title',
        description: 'New Description'
      }
    }
    json_patch(movie_url(@movie), @unauthorized_user, params)

    assert_access_forbidden
  end

  test "should update movie" do
    params = {
      movie: {
        category_id: Movie::Category::ANIMATION,
        title: 'New title',
        description: 'New Description'
      }
    }
    json_patch(movie_url(@movie), @user, params)

    assert_response :success

    assert_equal(
      params[:movie][:title],
      json_response['movie']['title'],
      'Should update movie title')
    assert_equal(
      params[:movie][:description],
      json_response['movie']['description'],
      'Should update movie title')
  end

  test "destroy_movie_by_unauthorized_user_fails" do
    assert_difference('Movie.count', 0) do
      json_delete(movie_url(@movie), @unauthorized_user)
    end

    assert_access_forbidden
  end

  test "should destroy movie" do
    assert_difference('Movie.count', -1) do
      json_delete(movie_url(@movie), @user)
    end

    assert_response :success
    assert_equal(
      I18n.t('movie.destroy.success'),
      json_response['message'],
      'Should set response message.')
  end

  def expected_movies_response(movies)
    movies.map do |movie|
      [
        movie.id, movie.title, movie.description,
        movie.avg_rating, movie.category_id, movie.category
      ]
    end
  end
end
