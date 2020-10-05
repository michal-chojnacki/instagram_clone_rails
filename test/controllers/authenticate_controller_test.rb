require 'test_helper'

class AuthenticateControllerTest < ActionDispatch::IntegrationTest
  test "when post authenticate without api key then response should be unauthorized" do
    # when
    post '/api/v1/authenticate', params: { authenticate: { username: "username", password: "password" } }
    
    # then
    assert_response :unauthorized
  end

  test "given user when post authenticate with api key and user then response should be authorized" do
    # given
    username = "fake_username"
    password = "fake_password"
    User.create(username: username, password: password)

    # when
    post '/api/v1/authenticate', params: { authenticate: { username: username, password: password } }, headers: { ApiKey: ENV['MOBILE_APP_KEY'] }
    
    # then
    assert_response :success
  end
end
