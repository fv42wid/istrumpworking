require 'test_helper'

class IssueIntegTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @mike = users(:mike)
    @admin = users(:frank)
    @issue = issues(:one)
  end

  test "unverified user cannot access edit or update" do
    get issue_path(@issue)
    assert_select "a[href=?]", edit_issue_path(@issue), text: "Edit", count: 0
    patch issue_path(@issue), params: {issue: {name: 'new name'} }
    assert_redirected_to new_user_session_path
  end

  test "unverified user cannot delete issue" do
    assert_no_difference 'Issue.count' do
      delete issue_path(@issue)
    end
    assert_redirected_to new_user_session_path
  end

  test "unverified user cannot acces new or create" do
    get root_path
    assert_select "a[hef=?]", new_issue_path, text: "Create Issue", count: 0
    get new_issue_path
    assert_redirected_to new_user_session_path
    assert_no_difference 'Issue.count' do
    post issues_path, params: {issue: {
        name: 'test issue', description: 'test descrip'
      } }
    end
    assert_redirected_to new_user_session_path
  end

  test "non-admin cannot access edit or update" do
    sign_in @mike
    get issue_path(@issue)
    assert_select "a[href=?]", edit_issue_path(@issue), text: "Edit", count: 0
    get edit_issue_path(@issue)
    assert_redirected_to root_path
    patch issue_path(@issue), params: {issue: {name: 'new name'} }
    assert_redirected_to root_path
  end
  
  test "non-admin cannot access delete" do
    sign_in @mike
    assert_no_difference 'Issue.count' do
      delete issue_path(@issue)
    end
    assert_redirected_to root_path
  end

  test "non-admin cannot access new or create" do
    sign_in @mike
    get root_path
    assert_select "a[href=?]", new_issue_path, text: "Create Issue", count: 0
    get new_issue_path
    assert_redirected_to root_path
    assert_no_difference 'Issue.count' do
      post issues_path, params: {issue: {
          name: 'new issue', description: 'new descrip'
        } }
    end
    assert_redirected_to root_path
  end


  test "admin can access new and create" do
    sign_in @admin
    get root_path
    assert_select "a[href=?]", new_issue_path, text: "Create Issue", count: 1
  end

  test "admin can access edit and update" do
    sign_in @admin
    get issue_path(@issue)
    assert_select "a[href=?]", edit_issue_path(@issue), text: "Edit", count: 1
    get edit_issue_path(@issue)
    assert_response :success
    assert_template 'issues/edit'
    patch issue_path(@issue), params: {issue: {name: 'new name'} }
    assert_redirected_to issue_path(@issue)
    follow_redirect!
    assert_template 'issues/show'
    assert_select "h1", "new name"
    assert_select "div[class=?]", "alert alert-success", text: "Issue updated!"
  end
  
end
