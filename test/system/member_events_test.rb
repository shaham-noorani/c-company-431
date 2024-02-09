require 'application_system_test_case'

class MemberEventsTest < ApplicationSystemTestCase
  setup do
    @member_event = member_events(:one)
  end

  test 'visiting the index' do
    visit member_events_url
    assert_selector 'h1', text: 'Member events'
  end

  test 'should create member event' do
    visit member_events_url
    click_on 'New member event'

    fill_in 'Date', with: @member_event.date
    fill_in 'Event', with: @member_event.event_id
    fill_in 'Time spent', with: @member_event.time_spent
    fill_in 'User', with: @member_event.user_id
    click_on 'Create Member event'

    assert_text 'Member event was successfully created'
    click_on 'Back'
  end

  test 'should update Member event' do
    visit member_event_url(@member_event)
    click_on 'Edit this member event', match: :first

    fill_in 'Date', with: @member_event.date
    fill_in 'Event', with: @member_event.event_id
    fill_in 'Time spent', with: @member_event.time_spent
    fill_in 'User', with: @member_event.user_id
    click_on 'Update Member event'

    assert_text 'Member event was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Member event' do
    visit member_event_url(@member_event)
    click_on 'Destroy this member event', match: :first

    assert_text 'Member event was successfully destroyed'
  end
end
