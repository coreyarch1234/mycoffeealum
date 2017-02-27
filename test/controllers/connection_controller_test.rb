require 'test_helper'

class ConnectionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get connection_index_url
    assert_response :success
  end

  test "should get create" do
    get connection_create_url
    assert_response :success
  end

  test "should get destroy" do
    get connection_destroy_url
    assert_response :success
  end

end
