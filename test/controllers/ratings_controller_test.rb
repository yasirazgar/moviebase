require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get(ratings_url)

    assert_response :success
    assert_equal(
      {
        "0"=>["Not Rated", 1],
        "1"=>["1 Star", 0],
        "2"=>["2 Stars", 0],
        "3"=>["3 Stars", 4],
        "4"=>["4 Stars", 1],
        "5"=>["5 Stars", 1]
      },
      json_response["ratings"],
      "Should return ratings and ratings_count")
  end
end
