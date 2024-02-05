require "test_helper"

class MemberActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member_activity = member_activities(:one)
  end

  test "should get index" do
    get member_activities_url
    assert_response :success
  end

  test "should get new" do
    get new_member_activity_url
    assert_response :success
  end

  test "should create member_activity" do
    assert_difference("MemberActivity.count") do
      post member_activities_url, params: { member_activity: { activity_id: @member_activity.activity_id, date: @member_activity.date, time_spent: @member_activity.time_spent, user_id: @member_activity.user_id } }
    end

    assert_redirected_to member_activity_url(MemberActivity.last)
  end

  test "should show member_activity" do
    get member_activity_url(@member_activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_member_activity_url(@member_activity)
    assert_response :success
  end

  test "should update member_activity" do
    patch member_activity_url(@member_activity), params: { member_activity: { activity_id: @member_activity.activity_id, date: @member_activity.date, time_spent: @member_activity.time_spent, user_id: @member_activity.user_id } }
    assert_redirected_to member_activity_url(@member_activity)
  end

  test "should destroy member_activity" do
    assert_difference("MemberActivity.count", -1) do
      delete member_activity_url(@member_activity)
    end

    assert_redirected_to member_activities_url
  end
end
