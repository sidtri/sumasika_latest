require 'test_helper'

class JsonersControllerTest < ActionController::TestCase
  test "should get ghana" do
    get :ghana
    assert_response :success
  end

end
