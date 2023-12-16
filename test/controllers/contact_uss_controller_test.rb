require "test_helper"

class ContactUssControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contact_uss_index_url
    assert_response :success
  end
end
