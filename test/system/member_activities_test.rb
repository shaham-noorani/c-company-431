require 'application_system_test_case'

class MemberActivitiesTest < ApplicationSystemTestCase
     setup do
          @member_activity = member_activities(:one)
     end

     test 'visiting the index' do
          visit member_activities_url
          assert_selector 'h1', text: 'Member activities'
     end

     test 'should create member activity' do
          visit member_activities_url
          click_on 'New member activity'

          fill_in 'Activity', with: @member_activity.activity_id
          fill_in 'Date', with: @member_activity.date
          fill_in 'Time spent', with: @member_activity.time_spent
          fill_in 'User', with: @member_activity.user_id
          click_on 'Create Member activity'

          assert_text 'Member activity was successfully created'
          click_on 'Back'
     end

     test 'should update Member activity' do
          visit member_activity_url(@member_activity)
          click_on 'Edit this member activity', match: :first

          fill_in 'Activity', with: @member_activity.activity_id
          fill_in 'Date', with: @member_activity.date
          fill_in 'Time spent', with: @member_activity.time_spent
          fill_in 'User', with: @member_activity.user_id
          click_on 'Update Member activity'

          assert_text 'Member activity was successfully updated'
          click_on 'Back'
     end

     test 'should destroy Member activity' do
          visit member_activity_url(@member_activity)
          click_on 'Destroy this member activity', match: :first

          assert_text 'Member activity was successfully destroyed'
     end
end
