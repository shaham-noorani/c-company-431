require 'test_helper'

class MemberActivitiesControllerTest < ActionDispatch::IntegrationTest
     setup do
          @member_activity = member_activities(:one)
     end

     test 'should get index' do
          get member_activities_url
          assert_response :success
     end

     test 'should get new' do
          get new_member_activity_url
          assert_response :success
     end

     test 'should create member_activity' do
          assert_difference('MemberActivity.count') do
               post member_activities_url,
                    params: {
                         member_activity: {
                              activity_id: @member_activity.activity_id,
                              date: @member_activity.date,
                              time_spent: @member_activity.time_spent,
                              user_id: @member_activity.user_id
                         }
                    }
          end

          assert_redirected_to member_activity_url(MemberActivity.last)
     end

     test 'should show member_activity' do
          get member_activity_url(@member_activity)
          assert_response :success
     end

     test 'should get edit' do
          get edit_member_activity_url(@member_activity)
          assert_response :success
     end

     test 'should update member_activity' do
          patch member_activity_url(@member_activity),
                params: {
                     member_activity: {
                          activity_id: @member_activity.activity_id,
                          date: @member_activity.date,
                          time_spent: @member_activity.time_spent,
                          user_id: @member_activity.user_id
                     }
                }
          assert_redirected_to member_activity_url(@member_activity)
     end

     test 'should destroy member_activity' do
          assert_difference('MemberActivity.count', -1) do
               delete member_activity_url(@member_activity)
          end

          assert_redirected_to member_activities_url
     end

     test 'should mark activity as complete' do
          patch mark_as_complete_member_activity_url(@member_activity), params: { end_time: '15:00' }
          assert_redirected_to member_activities_url
          @member_activity.reload
          assert @member_activity.completed
          assert_equal '15:00', @member_activity.end_time.strftime('%H:%M')
     end
      
     test 'should not mark activity as complete with invalid parameters' do
          # Assuming there's some validation on end_time that makes it invalid, adjust as necessary
          patch mark_as_complete_member_activity_url(@member_activity), params: { end_time: nil }
          assert_redirected_to member_activities_url
          @member_activity.reload
          assert_not @member_activity.completed
     end

     test 'mark_as_complete sets end_time and completes the activity' do
          end_time = Time.current.change(sec: 0) # Assuming end_time is a datetime
          patch mark_as_complete_member_activity_url(@member_activity), params: { end_time: end_time }
        
          assert_redirected_to member_activities_url
          @member_activity.reload
          assert @member_activity.completed
          assert_equal end_time, @member_activity.end_time
     end
        
     test 'mark_as_complete without end_time does not complete the activity' do
          patch mark_as_complete_member_activity_url(@member_activity)
        
          assert_redirected_to member_activities_url
          @member_activity.reload
          assert_not @member_activity.completed
     end

     test 'should not create member_activity with invalid parameters' do
          assert_no_difference('MemberActivity.count') do
               post member_activities_url, params: { member_activity: { activity_id: nil, user_id: nil } }
          end
        
          assert_response :unprocessable_entity
     end

     test 'should not update member_activity with invalid parameters' do
          patch member_activity_url(@member_activity), params: { member_activity: { activity_id: nil, user_id: nil } }
        
          assert_response :unprocessable_entity
          @member_activity.reload
          # Assert that important attributes haven't changed, assuming they were set initially
          assert_not_nil @member_activity.activity_id
          assert_not_nil @member_activity.user_id
     end

     test 'should not create member_activity with invalid parameters in JSON format' do
          assert_no_difference('MemberActivity.count') do
               post member_activities_url, params: { member_activity: { activity_id: nil, user_id: nil } }.to_json, headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
          end
        
          assert_response :unprocessable_entity
     end

     test 'should not create member_activity with invalid parameters' do
          assert_no_difference('MemberActivity.count') do
               post member_activities_url, params: { member_activity: { activity_id: nil, user_id: nil } }
          end
        
          assert_template :new
          assert_response :unprocessable_entity
     end
        
     test 'should not update member_activity with invalid parameters' do
          patch member_activity_url(@member_activity), params: { member_activity: { activity_id: nil, user_id: nil } }
        
          assert_template :edit
          assert_response :unprocessable_entity
     end
      
end
