require 'rails_helper'

RSpec.describe 'User management', type: :feature do
  describe 'destroying a user' do
    let!(:user) { User.create(first_name: 'joe', last_name: "bob", role: "pleb", email: "joe@gmail.com") }
    
    it 'destroys the user' do
      User.create(first_name: "joe", last_name: "bob", role: "admin", email: "joe1@gmail.com")
      session[":useremail"] = "joe1@gmail.com"
      visit user_path(user)

      click_on 'Destroy this user'

      expect(page).to have_content('User was successfully destroyed.')
    end
  end
end