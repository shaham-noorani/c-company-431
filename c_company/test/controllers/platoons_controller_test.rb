require "test_helper"

class PlatoonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @platoon = platoons(:one)
  end

  test "should get index" do
    get platoons_url
    assert_response :success
  end

  test "should get new" do
    get new_platoon_url
    assert_response :success
  end

  test "should create platoon" do
    assert_difference("Platoon.count") do
      post platoons_url, params: { platoon: { leader_id: @platoon.leader_id, name: @platoon.name } }
    end

    assert_redirected_to platoon_url(Platoon.last)
  end

  test "should show platoon" do
    get platoon_url(@platoon)
    assert_response :success
  end

  test "should get edit" do
    get edit_platoon_url(@platoon)
    assert_response :success
  end

  test "should update platoon" do
    patch platoon_url(@platoon), params: { platoon: { leader_id: @platoon.leader_id, name: @platoon.name } }
    assert_redirected_to platoon_url(@platoon)
  end

  test "should destroy platoon" do
    assert_difference("Platoon.count", -1) do
      delete platoon_url(@platoon)
    end

    assert_redirected_to platoons_url
  end
end
