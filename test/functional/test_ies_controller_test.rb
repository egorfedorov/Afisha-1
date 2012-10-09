require 'test_helper'

class TestIesControllerTest < ActionController::TestCase
  setup do
    @test_y = test_ies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_ies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_y" do
    assert_difference('TestY.count') do
      post :create, test_y: {  }
    end

    assert_redirected_to test_y_path(assigns(:test_y))
  end

  test "should show test_y" do
    get :show, id: @test_y
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_y
    assert_response :success
  end

  test "should update test_y" do
    put :update, id: @test_y, test_y: {  }
    assert_redirected_to test_y_path(assigns(:test_y))
  end

  test "should destroy test_y" do
    assert_difference('TestY.count', -1) do
      delete :destroy, id: @test_y
    end

    assert_redirected_to test_ies_path
  end
end
