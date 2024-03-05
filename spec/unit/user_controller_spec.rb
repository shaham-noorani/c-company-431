require 'rails_helper'

RSpec.describe(UsersController, type: :controller) do
     let(:user) { User.create!(first_name: 'joe', last_name: 'bob', role: 'admin', email: 'joe@gmail.com') }
     let(:platoon_leader) { User.create!(first_name: 'joe', last_name: 'bob', role: 'platoon_leader', email: 'joe@fmail.com') }
     let(:pleb_user) { User.create!(first_name: 'joe', last_name: 'bob', role: 'pleb', email: 'joe@bmail.com') }

     before do
          allow(controller).to(receive(:current_user).and_return(user))
     end

     describe 'GET #index' do
          context 'when user is admin' do
               it 'assigns all users as @users' do
                    session[':useremail'] = 'joe@gmail.com'
                    get :index
                    expect(assigns(:users)).to(eq(User.all))
               end
          end

          context 'when user is a platoon leader' do
               before { allow(controller).to(receive(:current_user).and_return(platoon_leader)) }

               it 'assigns users of the same platoon as @users' do
                    session[':useremail'] = 'joe@fmail.com'

                    get :index
                    expect(assigns(:users)).to(eq(User.where(platoon_id: platoon_leader.platoon_id)))
               end
          end

          context 'when user is not authorized' do
               before { allow(controller).to(receive(:current_user).and_return(pleb_user)) }

               it 'redirects to the root path' do
                    get :index
                    expect(response).to(redirect_to(root_path))
               end
          end
     end

     # Similar structure for #show, #new, #edit, #create, #update, #destroy

     describe 'POST #create' do
          context 'with valid params' do
               let(:valid_attributes) do
                    {
                         first_name: 'Jane',
                         last_name: 'Doe',
                         email: 'jane.doe@example.com',
                         role: 'admin'
                    }
               end

               it 'creates a new User' do
                    session[':useremail'] = 'joe@gmail.com'
                    expect do
                         post(:create, params: { user: valid_attributes })
                    end.to(change(User, :count).by(1))
               end

               it 'redirects to the created user' do
                    session[':useremail'] = 'joe@gmail.com'
                    post :create, params: { user: valid_attributes }
                    expect(response).to(redirect_to(User.last))
               end
          end

          context 'with invalid params' do
               let(:invalid_atts) do
                    {
                         first_name: 'jane'
                    }
               end

               it "doesn't create a new User" do
                    session[':useremail'] = 'joe@gmail.com'
                    expect do
                         post(:create, params: { user: invalid_atts })
                    end.not_to(change(User, :count))
               end
          end
     end

     describe 'POST #update' do
          context 'with valid params' do
               let!(:user_update) { User.create!(first_name: 'joe', last_name: 'bob', role: 'pleb', email: 'bob@gmail.com') }
               let(:new_attributes) do
                    { first_name: 'UpdatedName' }
               end

               it 'updates the requested user' do
                    session[':useremail'] = 'joe@gmail.com'
                    patch :update, params: { id: user_update.id, user: new_attributes }
                    user_update.reload
                    expect(user_update.first_name).to(eq('UpdatedName'))
               end

               it 'redirects to the user' do
                    session[':useremail'] = 'joe@gmail.com'
                    patch :update, params: { id: user_update.id, user: new_attributes }
                    expect(response).to(redirect_to(user_url(user_update)))
               end
          end

          context 'with invalid params' do
               let!(:user_update) { User.create!(first_name: 'joe', last_name: 'bob', role: 'pleb', email: 'bob@gmail.com') }
               let(:new_attributes) do
                    { first_name: nil }
               end

               it 'does not update the requested user' do
                    session[':useremail'] = 'joe@gmail.com'
                    patch :update, params: { id: user_update.id, user: new_attributes }
                    user_update.reload
                    expect(user_update.first_name).to(eq('joe'))
               end
          end

          context 'platoon_leader tries updating' do
               let!(:user_update) { User.create!(first_name: 'joe', last_name: 'bob', role: 'pleb', email: 'bob@gmail.com') }
               let(:new_attributes) do
                    { first_name: 'bob' }
               end

               User.create!(first_name: 'platoon', last_name: 'leader', role: 'platoon_leader', email: 'abc@gmail.com')

               it 'updates the requested user' do
                    session[':useremail'] = 'abc@gmail.com'
                    patch :update, params: { id: user_update.id, user: new_attributes }
                    user_update.reload
                    expect(user_update.first_name).to(eq('bob'))
               end
          end
     end
end
