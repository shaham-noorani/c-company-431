require 'rails_helper'

RSpec.describe('Activity management', type: :feature) do
     before do
          User.create!(first_name: 'Test', last_name: 'User', email: 'user@example.com', role: 'admin')
          OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
               provider: 'google_oauth2',
               info: {
                    email: 'user@example.com',
                    first_name: 'Test',
                    last_name: 'User'
               }
          }
                                                                            )
     end

     describe 'destroying an activity' do
          let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
          let!(:activity) { Activity.create(name: "a workout", activity_type_id: act_type.id, description: "running etc.") }

          it 'destroys the activity' do
               visit '/auth/google_oauth2'
               visit activity_path(activity)

               click_on 'Destroy this activity'

               expect(page).to(have_content('Activity was successfully destroyed.'))
          end
     end

     describe 'creating an activity' do
          let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
          it "creates activity" do
               visit '/auth/google_oauth2'
               visit activities_path
               click_on "New activity"
               fill_in "Name", with: "hello"
               select 'workout', from: 'Activity type'
               fill_in "Description", with: "hello2"
               click_on "Create Activity"
               expect(page).to(have_content("Activity was successfully created."))
          end
     end

     describe 'creating an activity with invalid' do
          let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
          it "creates activity" do
               visit '/auth/google_oauth2'
               visit activities_path
               click_on "New activity"
               select 'workout', from: 'Activity type'
               fill_in "Description", with: "hello2"
               click_on "Create Activity"
               expect(page).to(have_content("Name can't be blank"))
          end
     end

     describe 'creating an activity and assign it to a member' do
          let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
          it "creates activity" do
               visit '/auth/google_oauth2'
               visit activities_path
               click_on "New activity"
               fill_in "Name", with: "hello"
               select 'workout', from: 'Activity type'
               fill_in "Description", with: "hello2"
               click_on "Create Activity"
               expect(page).to(have_content("Activity was successfully created."))
               click_on "Assign to Member"
               select 'user@example.com', from: 'Select User:'
               fill_in "Deadline:", with: "2024-02-13 10:00 AM" 
               click_on 'Assign'
               expect(page).to(have_content("Activity was successfully assigned to the member."))
          end
     end

     describe 'creating an activity and assign it to a platoon' do
          let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
          let!(:my_platoon) {Platoon.create(name: "what up platoon", leader_id: User.find_by(email: "user@example.com").id)}
          it "creates activity" do
               visit '/auth/google_oauth2'
               visit activities_path
               click_on "New activity"
               fill_in "Name", with: "hello"
               select 'workout', from: 'Activity type'
               fill_in "Description", with: "hello2"
               click_on "Create Activity"
               expect(page).to(have_content("Activity was successfully created."))
               click_on "Assign to Platoon"
               select "what up platoon", from: "Select Platoon:"
               click_on "Assign"
               expect(page).to(have_content("Activity was successfully assigned to all members in the platoon."))
          end
     end

     describe 'updating an activity' do
          let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
          let!(:activity) { Activity.create(name: "a workout", activity_type_id: act_type.id, description: "running etc.") }
          it "updates activity" do
               visit '/auth/google_oauth2'
               visit activities_path
               click_on "Show this activity"
               click_on "Edit this activity"
               fill_in "Description", with: "whatathalkht"
               click_on "Update Activity"
               expect(page).to(have_content("Activity was successfully updated."))
          end
     end
end
