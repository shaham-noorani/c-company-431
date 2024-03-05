require 'rails_helper'

RSpec.describe(SessionsController, type: :controller) do
     before do
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

     describe 'POST #create' do
          context 'when user authenticates successfully' do
               before do
                    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
                    post :create, params: { provider: 'google_oauth2' }
               end

               it 'redirects to users path' do
                    expect(response).to(redirect_to(root_path))
               end

               it "creates a new user if one doesn't exist" do
                    expect(User.last.email).to(eq('user@example.com'))
                    expect(session[':useremail']).to(eq('user@example.com'))
               end

               it 'finds the existing user if one exists' do
                    expect do
                         post(:create, params: { provider: 'google_oauth2' })
                    end.not_to(change(User, :count))
                    expect(session[':useremail']).to(eq('user@example.com'))
               end
          end
     end
end
