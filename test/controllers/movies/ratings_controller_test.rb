require 'test_helper'

class Movies::RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating = ratings(:yasir_lion_king)
    @movie = movies(:lion_king)
    @yasir = users(:yasir)
    @user_no_rating = users(:azgar)
  end

  test 'create a rating if not available' do
    params = {
      movie_id: @movie.id,
      rating: 3
    }

    assert_nil(Rating.find_by(movie_id: @movie.id, user_id: @user_no_rating.id),
      "Initially user should not have rated for the movie")

    assert_difference('@movie.ratings.count', 1) do
      json_patch(rate_movie_ratings_url(@movie), @user_no_rating, params)
    end

    assert_equal(3, @movie.reload.avg_rating,
      "Should reset/update avg_rating")
  end

  test 'update rating if already available' do
    new_rating = 5
    old_rating = 3
    params = {
      movie_id: @movie.id,
      rating: new_rating
    }
    assert_equal(old_rating, @rating.rating,
      "Initially should have a rating of #{old_rating}")

    assert_difference('@movie.ratings.count', 0) do
      json_patch(rate_movie_ratings_url(@movie), @yasir, params)
    end

    assert_equal(new_rating, @rating.reload.rating,
      "Should update the rating to #{new_rating}")

    assert_equal(4, @movie.reload.avg_rating,
      "Should reset/update avg_rating")
  end
end
