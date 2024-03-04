require 'rails_helper'

RSpec.describe(AnalyticsController, type: :controller) do
     describe 'GET #index' do
          it 'returns http success' do
               get :index
               expect(response).to(have_http_status(:success))
          end
     end

     describe 'GET #analytics_logs' do
          it 'returns http success' do
               get :analytics_logs
               expect(response).to(have_http_status(:success))
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
