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
            click_on "New Member Activity"
            select "Test User", from: "User"
            select "a workout", from: "Activity"
            fill_in "Date", with: "11111111"
            fill_in "Start time", with: "1234AM"
            fill_in "End time", with: "1234AM"
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
            fill_in "Date", with: "11111111"
            fill_in "Start time", with: "1234AM"
            fill_in "End time", with: "1234AM"
            click_on "Update Member activity"
            expect(page).to(have_content("Member activity was successfully updated."))
        end
    end

    describe 'destroy' do
        let!(:act_type) {ActivityType.create(name: "workout", description: "running")}
        let!(:activity) { Activity.create(name: "a workout", activity_type_id: act_type.id, description: "running etc.") }
        let!(:member_activity) { MemberActivity.create(user_id: User.find_by(email: "user@example.com").id, activity_id: activity.id)}
        it 'test' do
            visit '/auth/google_oauth2'
            visit member_activities_path
            click_on "Show this member activity"
            click_on "Destroy this member activity"
            expect(page).to(have_content("Member activity was successfully destroyed."))
        end
    end
end