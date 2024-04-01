require 'rails_helper'

RSpec.describe PlatoonsController, type: :controller do
  before do
    user = User.create!(first_name: 'Test', last_name: 'User', email: 'user@example.com', role: 'admin')
    platoon = Platoon.create!(name: 'Alpha Platoon', leader_id: user.id)
    user.platoon = platoon
    user.save
    3.times { create(:user, platoon: platoon) }
  end

  describe "GET #my_platoon" do
    it "assigns the current user's platoon and members to @platoon and @members" do
      @request.session[':useremail'] = 'user@example.com'

      get :my_platoon

      expect(assigns(:current_user)).to eq(User.find_by(email: 'user@example.com'))
      expect(assigns(:platoon)).to eq(Platoon.find_by(name: 'Alpha Platoon'))
      expect(assigns(:members)).to match_array(Platoon.find_by(name: 'Alpha Platoon').users)
    end
  end
end
