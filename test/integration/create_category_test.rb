require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  #because these tests are testing for creation of categories which now require admin priveleges, we must sign in user
  setup do
    @category = categories(:one)
    @admin_user = User.create(username: "johndoe", email: "johndoe@gmail.com", password: "password", admin: true)

    sign_in(@admin_user)
  end

  test "get new category form and create category" do
    get categories_path
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Sports" } }
      #after sending post request to create new category, we're going to get a redirect response code
      assert_redirected_to category_url(Category.last)
      assert_response :redirect
    end
    #follow the redirect and make sure success response
    follow_redirect!
    assert_response :success
    #when the new category is successfully added and redirects back to the show page for this category, we expect that word to be somewhere in the html that gets sent back.
    assert_match "Sports", response.body
  end

  test "gete new category form and reject invalid category submission" do
    get new_category_path
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "" } }
    end
    #check for the keyword error anywhere in the response body
    assert_match "error", response.body
    #look for div with class alert in rendered html
    assert_select 'div.alert'
  end

end
