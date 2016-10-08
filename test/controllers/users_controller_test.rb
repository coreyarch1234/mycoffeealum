require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @invalid_user1 = User.new(first_name: "Maria", last_name: "Xu", email: "maria.xu@students.makeschool.com")
    @invalid_user2 = User.new(first_name: "Maria", last_name: "Xu", email: "maria.xu@students", password: "testxyz", password_confirmation: "testxyz")
    @valid_user = User.new(first_name: "Maria", last_name: "Xu", email: "maria.xu@students.makeschool.com", password: "testxyz", password_confirmation: "testxyz")
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "shoud be valid" do
    assert_not @invalid_user1.valid?
    assert_not @invalid_user2.valid?
    assert @valid_user.valid?
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @valid_user.email, first_name: @valid_user.first_name, last_name: @valid_user.last_name, password: @valid_user.password, password_confirmation: @valid_user.password_confirmation } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  # test "should update user" do
  #   patch user_url(@user), params: { user: { email: @user.email, first_name: @user.first_name, last_name: @user.last_name, password: @user.password, password_confirmation: @user.password_confirmation } }
  #   assert_redirected_to user_url(@user)
  # end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
