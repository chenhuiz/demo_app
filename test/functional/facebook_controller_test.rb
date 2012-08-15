require 'test_helper'

class FacebookControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get deactivate" do
    get :deactivate
    assert_response :success
  end

  test "should get post" do
    get :post
    assert_response :success
  end

end
