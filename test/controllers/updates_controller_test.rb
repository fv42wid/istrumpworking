require 'test_helper'

class UpdatesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @mike = users(:mike)
    @admin = users(:frank)
    @issue = issues(:one)
    @update = updates(:one)
  end

  test "unverified user is redirected from new update" do
    get new_issue_update_path(@issue)
    assert_redirected_to new_user_session_path
  end

  test "non-admin is redirected from new update" do
    sign_in @mike
    get new_issue_update_path(@issue)
    assert_redirected_to root_path
  end

  test "unverified user is redirected from create update" do
    assert_no_difference 'Update.count' do
      post issue_updates_path(@issue), params: {update: {
          name: "new update", description: "this is the desc", citation: "google.com", score: 1
        } }
    end
    assert_redirected_to new_user_session_path
  end

  test "non-admin is redirected from create update" do
    sign_in @mike
    assert_no_difference 'Update.count' do
      post issue_updates_path(@issue), params: {update: {
          name: "new update", description: "this is the desc", citation: "google.com", score: 1
        } }
    end
    assert_redirected_to root_path
  end

  test "unverified user cannot delete update" do
    assert_no_difference 'Update.count' do
      delete issue_update_path(@issue, @update)
    end
    assert_redirected_to new_user_session_path
  end

  test "non-admin cannot delete update" do
    sign_in @mike
    assert_no_difference 'Update.count' do
      delete issue_update_path(@issue, @update)
    end
    assert_redirected_to root_path
  end

  test "unverified cannot access edit update" do
    get edit_issue_update_path(@issue, @update)
    assert_redirected_to new_user_session_path
  end

  test "non-admin cannot access edit update" do
    sign_in @mike
    get edit_issue_update_path(@issue, @update)
    assert_redirected_to root_path
  end

  test "unverified user cannot edit update" do
    patch issue_update_path(@issue, @update), params: {update: {
        name: "test change", description: "no change", citation: "none", score: 1
      } }
    assert_redirected_to new_user_session_path
    get issue_update_path(@issue, @update)
    assert_select "h3", "First Update"
    assert_select "p#update-description", "description for the first update."
    assert_select "p#update-citation", "google.com"
  end

  test "non-admin cannot edit update" do
    sign_in @mike
    patch issue_update_path(@issue, @update), params: {update: {
        name: "test change", description: "no change", citation: "none", score: 1
      } }
    assert_redirected_to root_path
    get issue_update_path(@issue, @update)
    assert_select "h3", "First Update"
    assert_select "p#update-description", "description for the first update."
    assert_select "p#update-citation", "google.com"
  end
end
