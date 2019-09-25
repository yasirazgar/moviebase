require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get(categories_url)

    assert_response :success

    assert_equal(
      {
        "1"=>["Action", 2],
        "4"=>["Animation", 2],
        "3"=>["Comedy", 2],
        "2"=>["Drama", 1]
      },
      json_response["categories"],
      "Should return group categories")
  end
end
