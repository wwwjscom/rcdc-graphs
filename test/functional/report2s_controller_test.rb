require 'test_helper'

class Report2sControllerTest < ActionController::TestCase
  setup do
    @report2 = report2s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report2s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report2" do
    assert_difference('Report2.count') do
      post :create, :report2 => @report2.attributes
    end

    assert_redirected_to report2_path(assigns(:report2))
  end

  test "should show report2" do
    get :show, :id => @report2.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @report2.to_param
    assert_response :success
  end

  test "should update report2" do
    put :update, :id => @report2.to_param, :report2 => @report2.attributes
    assert_redirected_to report2_path(assigns(:report2))
  end

  test "should destroy report2" do
    assert_difference('Report2.count', -1) do
      delete :destroy, :id => @report2.to_param
    end

    assert_redirected_to report2s_path
  end
end
