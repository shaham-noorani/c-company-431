require 'rails_helper'

RSpec.describe('Activity types management', type: :feature) do
     before do
          User.create!(first_name: 'John', last_name: 'Doe', email: 'john@example.com', role: 'platoon_leader')
          OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
               provider: 'google_oauth2',
               info: {
                    email: 'john@example.com',
                    first_name: 'John',
                    last_name: 'Doe'
               }
          }
          )
          visit '/auth/google_oauth2'
     end
     it 'Creating an activity type with valid inputs' do
          visit new_activity_type_path
          fill_in 'activity_type[name]', with: 'Running'
          fill_in 'activity_type[description]', with: 'Run for exercise'
          click_on 'Create Activity type'
          visit activity_types_path
          expect(page).to(have_content('Running'))
          expect(page).to(have_content('Run for exercise'))
     end

     it 'Creating an activity type with blank name (rainy-day scenario)' do
          visit new_activity_type_path
          fill_in 'activity_type[name]', with: ''
          fill_in 'activity_type[description]', with: 'Run for exercise'
          click_on 'Create Activity type'
          expect(page).to(have_content("Name can't be blank"))
     end

     it 'Creating an activity type with blank description (rainy-day scenario)' do
          visit new_activity_type_path
          fill_in 'activity_type[name]', with: 'Running'
          fill_in 'activity_type[description]', with: ''
          click_on 'Create Activity type'
          expect(page).to(have_content("Description can't be blank"))
     end

     it 'Updating an activity type with valid inputs' do
          activity_type = ActivityType.create(name: 'Running', description: 'Outdoor physical activity')
          visit edit_activity_type_path(activity_type)
          fill_in 'activity_type[name]', with: 'Jogging'
          fill_in 'activity_type[description]', with: 'Jog for exercise'
          click_on 'Update Activity type'
          visit activity_types_path
          expect(page).to(have_content('Jogging'))
          expect(page).to(have_content('Jog for exercise'))
     end

     it 'Destroying an activity type' do
          activity_type = ActivityType.create(name: 'Running', description: 'Outdoor physical activity')

          # Visit the show page for the activity type
          visit activity_type_path(activity_type)

          # Click the "Destroy" button
          click_on 'Destroy'

          # Check for the absence of the destroyed activity type on the index page
          visit activity_types_path
          expect(page).to(have_no_content('Running'))
          expect(page).to(have_no_content('Outdoor physical activity'))
     end
end
