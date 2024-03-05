require 'application_system_test_case'

class PlatoonsTest < ApplicationSystemTestCase
     setup do
          @platoon = platoons(:one)
     end

     test 'visiting the index' do
          visit platoons_url
          assert_selector 'h1', text: 'Platoons'
     end

     test 'should create platoon' do
          visit platoons_url
          click_on 'New platoon'

          fill_in 'Leader', with: @platoon.leader_id
          fill_in 'Name', with: @platoon.name
          click_on 'Create Platoon'

          assert_text 'Platoon was successfully created'
          click_on 'Back'
     end

     test 'should update Platoon' do
          visit platoon_url(@platoon)
          click_on 'Edit this platoon', match: :first

          fill_in 'Leader', with: @platoon.leader_id
          fill_in 'Name', with: @platoon.name
          click_on 'Update Platoon'

          assert_text 'Platoon was successfully updated'
          click_on 'Back'
     end

     test 'should destroy Platoon' do
          visit platoon_url(@platoon)
          click_on 'Destroy this platoon', match: :first

          assert_text 'Platoon was successfully destroyed'
     end
end
