require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "create - login - success" do
    user = users(:yasir)
    params = {
      email: 'yasir@risk.com',
      password: 'PassworD%1'
    }

    post(login_url(format: :json), params: params)

    assert_response :success

    assert_equal(
      user.slice(:id, :name, :email), json_response['user'],
      "Should return username and email")
    assert_equal(
      I18n.t('authentication.success'), json_response['message'],
      "Should return sucess message")
    assert_not_nil(json_response['jwt'], "Should return jwt")
  end

  test "create - login - failure" do
    user = users(:yasir)
    params = {
      email: 'yasir@pas.com',
      password: 'PassworD@1'
    }

    post(login_url(format: :json), params: params)

    assert_response :unauthorized

    assert_equal(
      {"error" => {"message" => "Authentication failed."}},
      json_response,
      "Should return error message.")
  end
end
