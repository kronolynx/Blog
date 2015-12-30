require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "Sports")
  end

  # in this test we will test that we can create a category
  test "category should be valid" do
    assert @category.valid?
  end

  # in this test we will test that name is not empty
  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  # unique name
  test "name should be unique" do
    @category.save # we need to save our previous test in the db so we can test that is unique
    category2 = Category.new(name: "Sports")
    assert_not category2.valid?
  end

  # we dont want names longer than 25
  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  # or shorted than 3
  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end