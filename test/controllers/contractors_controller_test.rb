require "test_helper"

class ContractorsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get contractors_show_url
    assert_response :success
  end

  test "should get edit" do
    get contractors_edit_url
    assert_response :success
  end

  test "should get update" do
    get contractors_update_url
    assert_response :success
  end

  test "should get mypage" do
    get contractors_mypage_url
    assert_response :success
  end
end
