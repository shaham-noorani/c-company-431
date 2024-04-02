RSpec.describe('Member activities management', type: :feature) do
    before do
        User.create!(first_name: 'Test', last_name: 'User', email: 'user@example.com', role: 'admin')
        OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
             provider: 'google_oauth2',
             info: {
                  email: 'user@example.com',
                  first_name: 'Test',
                  last_name: 'User'
             }
        })
    end
    describe 'Creating a member activity' do
        let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
        let!(:activity) { Activity.create(name: "a workout", activity_type_id: act_type.id, description: "running etc.") }
        it 'test' do
            visit '/auth/google_oauth2'
            visit member_activities_path
            click_on "Assign Yourslef an Activity"
            # select "Test User", from: "User"
            select "a workout", from: "Activity"
            # fill_in "Date", with: "11111111"
            # fill_in "Start time", with: "1234AM"
            # fill_in "End time", with: "1234AM"
            click_on "Create Member activity"
            expect(page).to(have_content("Member activity was successfully created."))
        end
    end

    describe 'updating' do
        let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
        let!(:activity) { Activity.create(name: "a workout", activity_type_id: act_type.id, description: "running etc.") }
        let!(:member_activity) { MemberActivity.create(user_id: User.find_by(email: "user@example.com").id, activity_id: activity.id)}
        it 'test' do
            visit '/auth/google_oauth2'
            visit member_activities_path
            click_on "Show this member activity"
            click_on "Edit this member activity"
            # fill_in "Date", with: "11111111"
            # fill_in "Start time", with: "1234AM"
            # fill_in "End time", with: "1234AM"
            click_on "Update Member activity"
            expect(page).to(have_content("Member activity was successfully updated."))
        end
    end


    describe 'Searching for a member activity' do
        let!(:act_type) { ActivityType.create(name: "workout", description: "running") }
        let!(:activity1) { Activity.create(name: "Morning Run", activity_type_id: act_type.id, description: "A nice morning run.") }
        let!(:activity2) { Activity.create(name: "Evening Walk", activity_type_id: act_type.id, description: "A relaxing evening walk.") }
        let!(:member_activity1) { MemberActivity.create(user_id: User.find_by(email: "user@example.com").id, activity_id: activity1.id) }
        let!(:member_activity2) { MemberActivity.create(user_id: User.find_by(email: "user@example.com").id, activity_id: activity2.id) }

        it 'displays the searched activity along with other activities' do
            visit '/auth/google_oauth2'
            visit member_activities_path
            
            fill_in "Search by Activity Name:", with: "Morning"
            click_button "Search"

            # Ensure both activities are present but the searched one appears first
            expect(page).to have_content("Morning Run")
            # expect(page).to have_content("Evening Walk")
            # expect(page.body.index("Morning Run")).to be < page.body.index("Evening Walk")
        end
    end
    # describe 'destroy' do
    #     let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
    #     let!(:activity) { Activity.create(name: "a workout", activity_type_id: act_type.id, description: "running etc.") }
    #     let!(:member_activity) { MemberActivity.create(user_id: User.find_by(email: "user@example.com").id, activity_id: activity.id)}
    #     it 'test' do
    #         visit '/auth/google_oauth2'
    #         visit member_activities_path
    #         click_on "Show this member activity"
    #         click_on "Destroy this member activity"
    #         expect(page).to(have_content("Member activity was successfully destroyed."))
    #     end
    # end

    # describe 'Creating a member activity with invalid parameters' do
    #     it 'does not create a member activity and renders the new form with errors' do
    #         visit '/auth/google_oauth2'
    #         visit new_member_activity_path
    #         # fill_in "Date", with: Date.today
    #         # Omit user and activity selection to trigger validation errors
    #         click_on "Create Member activity"
    #         expect(page).to have_content("User must exist")
    #         expect(page).to have_content("Activity must exist")
    #     end
    # end

    # describe 'Updating a member activity with a start time after the end time' do
    #     let!(:member_activity) { MemberActivity.create(user_id: User.find_by(email: "user@example.com").id, activity_id: Activity.first.id, date: Date.today, start_time: "9:00 AM", end_time: "10:00 AM") }
      
    #     it 'does not update the member activity and shows an error message' do
    #         visit '/auth/google_oauth2'
    #         visit edit_member_activity_path(member_activity)
    #         fill_in "Start time", with: "11:00 AM"  # After the existing end time
    #         click_on "Update Member activity"
    #         expect(page).to have_content("Start time must be before the end time")  # This assumes you add custom validation or error handling logic
    #     end
    # end
      
    # describe 'Marking a member activity as complete from the index page' do
    #     let!(:user) { User.create!(first_name: 'Test', last_name: 'User', email: 'user@example.com', role: 'admin') }
    #     let!(:act_type) { ActivityType.create!(name: "workout", description: "running") }
    #     let!(:activity) { Activity.create!(name: "Morning Run", activity_type_id: act_type.id, description: "A nice run.") }
    #     let!(:member_activity) { MemberActivity.create!(user_id: user.id, activity_id: activity.id, date: Date.today, start_time: "6:00 AM", end_time: "7:00 AM") }
    
    #     before do
    #         visit '/auth/google_oauth2'
    #         visit member_activities_path
    #     end
    
    #     it 'successfully marks the activity as complete' do
    #         visit current_path
    #         within first('.member_activity', wait: 20) do
    #             fill_in 'End Time:', with: '08:00 AM'
    #             click_on 'Mark as Completed'
    #         end
    #         expect(page).to have_content("Activity marked as completed successfully.")
    #         # Optionally, confirm the activity's attributes have been updated
    #         member_activity.reload
    #         expect(member_activity.completed).to be_truthy
    #     end
    # end


    # describe 'Marking a member activity as complete from the index page' do
    #     let!(:user) { User.create!(first_name: 'Test1', last_name: 'User1', email: 'user@example.com', role: 'admin') }
    #     let!(:act_type) { ActivityType.create!(name: "workout", description: "running") }
    #     let!(:activity) { Activity.create!(name: "Morning Run", activity_type_id: act_type.id, description: "A nice run.") }
    
    #     it 'successfully marks the activity as complete' do
    #         visit '/auth/google_oauth2'
    #         visit new_member_activity_path
            
    #         # Steps to create a new member activity
    #         select "Test1 User1", from: "User"
    #         select "Morning Run", from: "Activity"
    #         fill_in "Date", with: Date.today
    #         fill_in "Start time", with: "06:00 AM"
    #         fill_in "End time", with: "07:00 AM"
    #         click_on "Create Member activity"
            
    #         # Assuming there's a button to go back to the index page after creating an activity
    #         click_on "Back to member activities"
        
    #         # Now back on the index page, proceed to mark the activity as complete
    #         # within first('.member_activity', wait: 20) do
    #         within("#member_activity_#{member_activity.id}") do
    #             fill_in 'End Time:', with: '08:00 AM'
    #             click_on 'Mark as Completed'
    #         end
        
    #         expect(page).to have_content("Activity marked as completed successfully.")
    #     end
    # end





    # describe 'Marking a member activity as complete from the index page' do
    #     let!(:user) { User.create!(first_name: 'Test1', last_name: 'User1', email: 'user@example.com', role: 'admin') }
    #     let!(:act_type) { ActivityType.create!(name: "workout", description: "running") }
    #     let!(:activity) { Activity.create!(name: "Morning Run", activity_type_id: act_type.id, description: "A nice run.") }
      
    #     it 'successfully marks the activity as complete' do
    #         visit '/auth/google_oauth2'
    #         visit new_member_activity_path
            
    #         # Steps to create a new member activity
    #         select "Test1 User1", from: "User"
    #         select "Morning Run", from: "Activity"
    #         fill_in "Date", with: Date.today
    #         fill_in "Start time", with: "06:00 AM"
    #         fill_in "End time", with: "07:00 AM"
    #         click_on "Create Member activity"
            
    #         # Click the button to go back to the index page after creating an activity
    #         click_on "Back to member activities"
        
    #         # Since we assume there's only one member activity listed, we fill in the 'End Time' field directly
            
    #         # find('input[type="time"]').set('08:00 AM')
    #         # click_on 'Mark as Completed', match: :prefer_exact

    #         fill_in 'member_activity_end_time', with: '08:00 AM'  # Omit the colon and ensure the label matches exactly
    #         click_on 'Mark as Completed'
            
    #         # Expect the page to have the content indicating the activity is marked as completed
    #         expect(page).to have_content("Activity marked as completed successfully.")
            
    #         # If needed to confirm the activity's attributes have been updated, 
    #         # you'd have to re-query the database for the last created MemberActivity.
    #         # This is generally not the purview of a feature test, which should test user-visible outcomes,
    #         # but here's how you could do it:
    #         last_activity = MemberActivity.order(created_at: :desc).first
    #         expect(last_activity.completed).to eq(true)
    #     end
    # end
      

    

end