require 'test_helper'

class IssueControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @mike = users(:mike)
    @admin = users(:frank)
    @issue = issues(:one)
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

  test "unverified user is redirected from edit issue" do
    get edit_issue_path(@issue)
    assert_redirected_to new_user_session_path
  end

  test "unverified user redirected from update issue" do
    patch issue_path(@issue), params: {issue: {
        name: 'change name', description: 'new description'
      } }
    assert_redirected_to new_user_session_path
    get issue_path(@issue)
    assert_select "h1", "Issue One"
    assert_select "p", "This is the first issue."
  end

  test "non-admin user redirected from edit issue" do
    sign_in @mike
    get edit_issue_path(@issue)
    assert_redirected_to root_path
  end

  test "non-admin user redirected from update issue" do
    sign_in @mike
    patch issue_path(@issue), params: {issue: {
        name: 'change name', description: 'new description'
      } }
    assert_redirected_to root_path
    get issue_path(@issue)
    assert_select "h1", "Issue One"
    assert_select "p", "This is the first issue."
  end

  test "admin can access edit and update" do
    sign_in @admin
    get edit_issue_path(@issue)
    assert_response :success
    assert_template 'issues/edit'
    patch issue_path(@issue), params: {issue: {
      name: 'change name', description: 'new description'
      } }
    assert_redirected_to issue_path(@issue)
    follow_redirect!
    assert_template 'issues/show'
    assert_select "h1", "change name"
    assert_select "p", "new description"    
    assert_select "div[class=?]", "alert alert-success", "Issue updated!"
  end

  test "unverified user is redirected from destroy" do
    assert_no_difference 'Issue.count' do
      delete issue_path(@issue)
    end
    assert_redirected_to new_user_session_path
  end

  test "non-admin user redirected from destroy" do
    sign_in @mike
    assert_no_difference 'Issue.count' do
      delete issue_path(@issue)
    end
    assert_redirected_to root_path    
  end

  test "admin can destroy issue" do
    sign_in @admin
    assert_difference 'Issue.count', -1 do
      delete issue_path(@issue)
    end
    assert_redirected_to issues_path
    follow_redirect!
    assert_select "div[class=?]", "alert alert-success", "Issue deleted!"
  end

end
