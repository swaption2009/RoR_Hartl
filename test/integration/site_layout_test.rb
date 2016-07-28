require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:archer)
  	@other_user = users(:michael)
  end

  test "renders all of the links" do
  	get contact_path
  	assert_template 'static_pages/contact'
  	assert_select "a[href=?]", root_path, count: 2
  	assert_select "a[href=?]", help_path
  	assert_select "a[href=?]", about_path
  	assert_select "a[href=?]", contact_path
  	assert_select "title", full_title("Contact")
  end

  test "Layout links work properly" do
  	log_in_as @user
  	get root_path
  	assert_template 'static_pages/home'
  	assert_select "a[href=?]", root_path, count: 2
  	assert_select "a[href=?]", help_path
  	assert_select "a[href=?]", about_path
  	assert_select "a[href=?]", contact_path
  	assert_select "a[href=?]", users_path
  	assert_select "a[href=?]", user_path(@user)
		assert_select "a[href=?]", edit_user_path(@user)
		assert_select "a[href=?]", logout_path
		get users_path
		assert_template 'users/index'
		get user_path(@user)
		assert_template 'users/show'
		get edit_user_path
		assert_template 'users/edit'
		get edit_user_path(@other_user)
		follow_redirect!
		assert_template 'static_pages/home'
		delete logout_path
		follow_redirect!
		assert_template 'static_pages/home'
		assert_not is_logged_in?
		assert_select "a[href=?]", users_path, count: 0
  end

end
