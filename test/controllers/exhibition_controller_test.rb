require 'test_helper'

class ExhibitionControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
