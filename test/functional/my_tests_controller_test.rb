require 'test_helper'

class MyTestsControllerTest < ActionController::TestCase
  setup do
    @my_test = my_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_test" do
    assert_difference('MyTest.count') do
      post :create, my_test: {  }
    end

    assert_redirected_to my_test_path(assigns(:my_test))
  end

  test "should show my_test" do
    get :show, id: @my_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @my_test
    assert_response :success
  end

  test "should update my_test" do
    put :update, id: @my_test, my_test: {  }
    assert_redirected_to my_test_path(assigns(:my_test))
  end

  test "should destroy my_test" do
    assert_difference('MyTest.count', -1) do
      delete :destroy, id: @my_test
    end

    assert_redirected_to my_tests_path
  end
end
