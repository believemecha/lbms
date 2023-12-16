require "test_helper"

class GuidelinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guidelines_index_url
    assert_response :success
  end
end
