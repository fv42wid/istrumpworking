require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup with email missing" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: {user: {
          email: "", username: "sean", password: "testpass", password_confirmation: "testpass"
        } }
    end

    assert_select "div.alert-danger" do
      assert_select "li", "Email can't be blank"
    end
  end

  test "username can't be blank" do
    get new_user_registration_path
    assert_no_difference "User.count" do
      post user_registration_path, params: {user: {
          email: 'test@test.com', username: '', password: 'testpass', password_confirmation: 'testpass'
        } }
    end
    assert_select "div.alert-danger" do
      assert_select "li", "Username can't be blank"
    end
  end

  test "password can't be blank" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: {user: {
          email: 'test@test.com', username: 'tester', password: '', password_confirmation: ''
        } }
    end
    assert_select "div.alert-danger" do
      assert_select "li", "Password can't be blank"
    end
  end
  
  test "password mismatch" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: {user: {
          email: 'test@test.com', username: 'tester', password: 'testpass', password_confirmation: 'passtest'
        } }
    end
    assert_select "div.alert-danger" do
      assert_select "li", "Password confirmation doesn't match Password"
    end
  end

  test "valid signup" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: {user: {
          email: 'test@test.com', username: 'tester', password: 'testpass', password_confirmation: 'testpass'
        } }
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_select "div.alert-notice", "Welcome! You have signed up successfully."
  end
end
