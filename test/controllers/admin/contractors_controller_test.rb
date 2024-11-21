require "test_helper"

class Admin::ContractorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_contractors_index_url
    assert_response :success
  end
end
