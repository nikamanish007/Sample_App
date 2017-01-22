require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid user information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, params: {
  			user: {
  				name: "",
  				email: "user@invalid",
  				password: "foo",
  				password_confirmation: "bar"
  			}
  		}
  	end
  	assert_template 'users/new'
  end

  test "valid user infromation" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: {
  			user: {
  				name: "Example",
  				email: "user@ma.com",
  				password: "manish",
  				password_confirmation: "manish"
  			}
  		}
  	end
  	follow_redirect!
  	assert_template 'users/show'
  	assert_not flash.empty?
    assert is_logged_in?
  end
end