require 'test_helper'

class MemberEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member_event = member_events(:one)
  end

  test 'should get index' do
    get member_events_url
    assert_response :success
  end

  test 'should get new' do
    get new_member_event_url
    assert_response :success
  end

  test 'should create member_event' do
    assert_difference('MemberEvent.count') do
      post member_events_url,
           params: {
             member_event: {
               date: @member_event.date,
               event_id: @member_event.event_id,
               time_spent: @member_event.time_spent,
               user_id: @member_event.user_id
             }
           }
    end

    assert_redirected_to member_event_url(MemberEvent.last)
  end

  test 'should show member_event' do
    get member_event_url(@member_event)
    assert_response :success
  end

  test 'should get edit' do
    get edit_member_event_url(@member_event)
    assert_response :success
  end

  test 'should update member_event' do
    patch member_event_url(@member_event),
          params: {
            member_event: {
              date: @member_event.date,
              event_id: @member_event.event_id,
              time_spent: @member_event.time_spent,
              user_id: @member_event.user_id
            }
          }
    assert_redirected_to member_event_url(@member_event)
  end

  test 'should destroy member_event' do
    assert_difference('MemberEvent.count', -1) do
      delete member_event_url(@member_event)
    end

    assert_redirected_to member_events_url
  end
end
