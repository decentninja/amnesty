require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get apidoc" do
    get :apidoc
    assert_response :success
  end

end
