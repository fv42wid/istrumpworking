require 'test_helper'

class UserSigninTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @mike = users(:mike)
    @admin = users(:frank)
  end

  test "non-admin login" do
    get root_path
    assert_select "a[href=?]", new_user_registration_path
    assert_select "a[href=?]", new_user_session_path
    get new_user_session_path
    sign_in @mike
    get root_path
    assert_select "a[href=?]", "#", "mikey"
    assert_select "a[href=?]", destroy_user_session_path, "Sign out"
  end
end
