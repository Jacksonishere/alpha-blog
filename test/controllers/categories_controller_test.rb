require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @admin_user = User.create(username: "johndoe", email: "johndoe@gmail.com", password: "password", admin: true)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    #test for only admin
    sign_in(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    #when you create a category to the categories tables, you should see a different in the count, in this case by 1
    #test for only admin
    sign_in(@admin_user)
    assert_difference('Category.count', 1) do
      post categories_url, params: { category: { name: "Travel" } }
    end
    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not admin" do
    #when you create a category to the categories tables, you should see a different in the count, in this case by 1
    assert_no_difference 'Category.count' do
      post categories_url, params: { category: { name: "Travel" } }
    end
    assert_redirected_to categories_path
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
