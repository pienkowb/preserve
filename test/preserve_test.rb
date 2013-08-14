require 'test_helper'

class PreserveTest < ActionController::TestCase
  tests PreserveController

  test "a parameter value should be preserved" do
    get :index, per_page: 20
    assert_equal 20, session[:preserve_per_page].to_i
  end
end
