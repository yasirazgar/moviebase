require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:snatch)
    @user = users(:azgar)
    @unauthorized_user = users(:yasir)
  end

  test "should get index" do
    get movies_url

    assert_response :success

    movies = [
      movies(:pulp_fiction),
      movies(:reservoir_dogs),
      movies(:inside_out),
      movies(:lion_king),
      movies(:god_father),
      movies(:snatch),
      movies(:no_rating)
    ]
    assert_equal(
      movies.map{|movie| [movie.title, movie.description] },
      json_response['movies'],
      "Should return all movies")
  end

  test "should create movie" do
    params = {
      movie: {
        category_id: Movie::Category::Action,
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
        category_id: Movie::Category::Animation,
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
        category_id: Movie::Category::Animation,
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
end
