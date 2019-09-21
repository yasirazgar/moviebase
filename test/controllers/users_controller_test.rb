require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "create_success" do
    params = {
      user:{
        name: 'Yash',
        email: 'yash@rm.com',
        password: 'passworD@1'
      }
    }
    assert_difference('User.count', 1) do
      post(signup_url(format: :json), params: params)
      assert_response :success
    end
    assert_equal(
      I18n.t('user.create.success'), json_response['message'],
      "Should return success message")
  end

  test "create_failure" do
    params = {
      user: {
        name: 'Yasir',
        email: 'yasir@risk.com',
        password: 'passworD@1'
      }
    }
    assert_difference('User.count', 0) do
      post(signup_url(format: :json), params: params)
      assert_response :unprocessable_entity
    end
    assert_not_nil(
      json_response['error']['message'],
      "Should return failure message")
  end
end
