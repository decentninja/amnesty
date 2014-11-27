require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get create_role" do
    get :create_role
    assert_response :success
  end

  test "should get create_privilege" do
    get :create_privilege
    assert_response :success
  end

end
