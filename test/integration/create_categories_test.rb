require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
     # we need to simulate that an admin is logged in to test new
    @user = User.create(username: "Krono", email: "krono@gmail.com", password: "password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "Sports"}
    end
    assert_template 'categories/index'
    assert_match "Sports", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title' # we are checking that the flash error is displayed verifying
    assert_select 'div.panel-body' # that the div and h2 in our errors.html is on the screen
  end
end