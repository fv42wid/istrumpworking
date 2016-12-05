require 'test_helper'

class IssueTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @mike = users(:mike)
    @admin = users(:frank)
    @issue = issues(:one)
  end

  
end
