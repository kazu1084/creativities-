require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get mypage" do
    get clients_mypage_url
    assert_response :success
  end

  test "should get show" do
    get clients_show_url
    assert_response :success
  end

  test "should get edit" do
    get clients_edit_url
    assert_response :success
  end

  test "should get update" do
    get clients_update_url
    assert_response :success
  end

  test "should get destroy" do
    get clients_destroy_url
    assert_response :success
  end
end
