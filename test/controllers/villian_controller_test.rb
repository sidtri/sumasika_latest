require 'test_helper'

class VillianControllerTest < ActionController::TestCase
  test "should get user_destroy" do
    get :user_destroy
    assert_response :success
  end

  test "should get admin_destroy" do
    get :admin_destroy
    assert_response :success
  end

end
