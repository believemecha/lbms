require "test_helper"

class CollaboratedCollegesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get collaborated_colleges_index_url
    assert_response :success
  end
end
