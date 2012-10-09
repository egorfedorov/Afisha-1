require 'test_helper'

class WersControllerTest < ActionController::TestCase
  setup do
    @wer = wers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wer" do
    assert_difference('Wer.count') do
      post :create, wer: { name: @wer.name }
    end

    assert_redirected_to wer_path(assigns(:wer))
  end

  test "should show wer" do
    get :show, id: @wer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wer
    assert_response :success
  end

  test "should update wer" do
    put :update, id: @wer, wer: { name: @wer.name }
    assert_redirected_to wer_path(assigns(:wer))
  end

  test "should destroy wer" do
    assert_difference('Wer.count', -1) do
      delete :destroy, id: @wer
    end

    assert_redirected_to wers_path
  end
end
