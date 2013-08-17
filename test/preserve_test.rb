require 'test_helper'

class PreserveTest < ActionController::TestCase
  tests PreserveController

  test "a parameter value should be preserved" do
    get :index, per_page: 20
    assert_equal 20, session[:preserve_per_page].to_i
  end

  test "a parameter value should be updated" do
    get :index, per_page: 20
    get :index, per_page: 10

    assert_equal 10, session[:preserve_per_page].to_i
  end

  test "multiple parameters should be handled" do
    get :index, per_page: 20, order: 'created_at'

    assert_equal 20, session[:preserve_per_page].to_i
    assert_equal 'created_at', session[:preserve_order]
  end
end
