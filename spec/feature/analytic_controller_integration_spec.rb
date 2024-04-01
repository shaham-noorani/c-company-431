require 'rails_helper'

RSpec.describe(AnalyticsController, type: :controller) do
     before do
          User.create!(first_name: 'Test', last_name: 'User', email: 'user@example.com', role: 'admin')
          session[":useremail"] = "user@example.com"
     end
     describe 'GET #index' do
          it 'returns http success' do
               get :index
               expect(response).to(have_http_status(:success))
          end
          it 'filters analytics with valid user' do
               get :index, params: { startDate: '2024-03-31', user_id: 'User, Test: user@example.com' }
               expect(response).to have_http_status(:success)
               expect(response).to render_template(:index)
               # Add additional expectations as needed
             end
          
          it 'filters analytics with invalid user' do
               get :index, params: { startDate: '2024-03-31', user_id: 'Invalid User' }
               expect(response).to have_http_status(:redirect)
               expect(response).to redirect_to(analytics_path)
               expect(flash[:error]).to eq("Please select a valid user.")
               # Add additional expectations as needed
             end
     end

     describe 'GET #analytics_logs' do
          it 'returns http success' do
               get :analytics_logs
               expect(response).to(have_http_status(:success))
          end
          it 'filters analytics with valid user' do
               get :analytics_logs, params: { startDate: '2024-03-31', user_id: 'User, Test: user@example.com' }
               expect(response).to have_http_status(:success)
               expect(response).to render_template(:analytics_logs)
               # Add additional expectations as needed
             end
          
          it 'filters analytics with invalid user' do
               get :analytics_logs, params: { startDate: '2024-03-31', user_id: 'Invalid User' }
               expect(response).to have_http_status(:redirect)
               expect(response).to redirect_to(analytics_logs_path)
               expect(flash[:error]).to eq("Please select a valid user.")
               # Add additional expectations as needed
             end
          
     end

     describe 'GET #platoon_analytics' do
          it 'returns http success' do
               platoon = Platoon.new(name: 'Alpha Platoon', leader_id: 1)
               #   puts "Platoon valid: #{platoon.valid?}" # Check if the Platoon object is valid
               platoon.save # Attempt to save the Platoon object
               #   puts "Platoon ID: #{platoon.id}" # Print out the ID for troubleshooting
               get :platoon_analytics, params: { platoon_id: platoon.id }
               expect(response).to(have_http_status(:success))
          end
     end

     describe 'GET #platoon_logs' do
          it 'returns http success' do
               platoon = Platoon.new(name: 'Alpha Platoon', leader_id: 1)
               #   puts "Platoon valid: #{platoon.valid?}" # Check if the Platoon object is valid
               platoon.save # Attempt to save the Platoon object
               #   puts "Platoon ID: #{platoon.id}" # Print out the ID for troubleshooting
               get :platoon_logs, params: { platoon_id: platoon.id }
               expect(response).to(have_http_status(:success))
          end
     end
end
