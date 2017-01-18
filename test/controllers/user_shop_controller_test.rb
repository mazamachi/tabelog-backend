require 'test_helper'

class UserShopControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
