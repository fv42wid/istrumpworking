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
  
end
