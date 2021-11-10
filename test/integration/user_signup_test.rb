require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest

  test "user signup for a new account" do
    get signup_path
    assert_response :success

    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "jackster", email: "jackster11@gmail.com", password: "jacksonian" } }
      #after sending post request to create new category, we're going to get a redirect response code
      assert_redirected_to articles_path
      assert_response :redirect

    end
    follow_redirect!
    assert_response :success
    assert_match "jackster", response.body
  end
end
