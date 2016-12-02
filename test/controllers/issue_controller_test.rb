require 'test_helper'

class IssueControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @mike = users(:mike)
    @admin = users(:frank)
  end

  test "unverified user is redirected from new issue" do
    get new_issue_path
    assert_redirected_to new_user_session_path
  end

  test "non-admin user is redirected from new issue" do
    sign_in @mike
    get new_issue_path
    assert_redirected_to root_path
  end

  test "unverified user is redirected from create issue" do
    assert_no_difference 'Issue.count' do
      post issues_path, params: {isssue: {name: 'test issue', description: 'this is a test'} }
    end
    assert_redirected_to new_user_session_path
  end

  test "non-admin user is redirected from create issue" do
    sign_in @mike
    assert_no_difference 'Issue.count' do
      post issues_path, params: {issue: {name: 'test', description: 'this is atest'} }
    end
    assert_redirected_to root_path
  end

  test "admin can access new issue" do
    sign_in @admin
    get new_issue_path
    assert_response :success
    assert_template 'issues/new'
  end

  test "admin can create new issue" do
    sign_in @admin
    assert_difference 'Issue.count', 1 do
      post issues_path, params: {issue: {name: 'test', description: 'this is a test'} }
    end
    assert_redirected_to issue_path(Issue.last)
    follow_redirect!
    assert_template 'issues/show'
    assert_select "h1", "test"
  end

end
