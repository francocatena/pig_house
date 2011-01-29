require 'test_helper'

class PigsControllerTest < ActionController::TestCase
  setup do
    @pig = pigs(:mother)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:pigs)
    assert_select '#error_body', false
    assert_template 'pigs/index'
  end

  test 'should get new' do
    get :new
    assert_response :success
    assert_not_nil assigns(:pig)
    assert_select '#error_body', false
    assert_template 'pigs/new'
  end

  test 'should create pig' do
    assert_difference('Pig.count') do
      post :create, :pig => {
        :tag => 'New tag',
        :birth => 10.days.ago.to_date,
        :genetics => 'New genetics',
        :group => 'New group',
        :location => 'New location'
      }
    end

    assert_redirected_to pigs_path
  end

  test 'should show pig' do
    get :show, :id => @pig.to_param
    assert_response :success
    assert_not_nil assigns(:pig)
    assert_select '#error_body', false
    assert_template 'pigs/show'
  end

  test 'should get edit' do
    get :edit, :id => @pig.to_param
    assert_response :success
    assert_not_nil assigns(:pig)
    assert_select '#error_body', false
    assert_template 'pigs/edit'
  end

  test 'should update pig' do
    put :update, :id => @pig.to_param, :pig => {
      :tag => 'Updated tag',
      :birth => 10.days.ago.to_date,
      :genetics => 'Updated genetics',
      :group => 'Updated group',
      :location => 'Updated location'
    }
    assert_redirected_to pigs_path
    assert_equal 'Updated tag', @pig.reload.tag
  end

  test 'should destroy pig' do
    assert_difference('Pig.count', -1) do
      delete :destroy, :id => @pig.to_param
    end

    assert_redirected_to pigs_path
  end
end