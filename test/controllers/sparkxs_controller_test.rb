require "test_helper"

class SparkxsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sparkxs_index_url
    assert_response :success
  end
end
