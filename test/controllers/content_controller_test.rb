require 'test_helper'

class ContentControllerTest < ActionDispatch::IntegrationTest
  test "when get main_content without api key then response should be unauthorized" do
    # when
    get '/api/v1/main_content'
    
    # then
    assert_response :unauthorized
  end

  test "given user when get main_content with valid jwt then response should be authorized empty response" do
    # given
    user = User.find_by(username: "username_1")
    jsonWebToken = JsonWebToken.encode(user_id: user.id)
    expected = { contents:  Content.all, page:0, pages: 1}.to_json

    # when
    get '/api/v1/main_content', headers: { ApiKey: ENV['MOBILE_APP_KEY'], Authorization: "Bearer: #{jsonWebToken}" }
    
    # then
    assert_response :success
    assert_equal expected, @response.body
  end
end
