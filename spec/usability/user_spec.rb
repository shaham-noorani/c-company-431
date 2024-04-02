RSpec.describe('User management', type: :feature) do
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
    describe 'searching for a user sunny' do
        let!(:user) { User.create(first_name: 'joe', last_name: 'bob', role: 'pleb', email: 'joe@gmail.com') }

        it 'search the user' do
            visit '/auth/google_oauth2'
            visit users_path

            fill_in "Search for users:", with: "j"
            click_on "Search"
            expect(page).to(have_content('joe'))
        end
    end
    describe 'searching for a user rainy' do
        let!(:user) { User.create(first_name: 'joe', last_name: 'bob', role: 'pleb', email: 'joe@gmail.com') }

        it 'search the user' do
            visit '/auth/google_oauth2'
            visit users_path

            fill_in "Search for users:", with: "z"
            click_on "Search"
            expect(page).not_to have_content('joe')
        end
    end
end