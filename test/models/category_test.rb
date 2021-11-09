require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  #assert, if statement evaluates to true, success
  #assert_not, if statement evaluates false, success

  #ran before each test is ran
  #own database is used for tests, dont got to worry about the dev/main one
  def setup
    @category = Category.new(name: "Sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = ""
    #test for false, wont trigger failure.
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end

end
