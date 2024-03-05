require 'application_system_test_case'

class ActivityTypesTest < ApplicationSystemTestCase
     setup do
          @activity_type = activity_types(:one)
     end

     test 'visiting the index' do
          visit activity_types_url
          assert_selector 'h1', text: 'Activity types'
     end

     test 'should create activity type' do
          visit activity_types_url
          click_on 'New activity type'

          fill_in 'Description', with: @activity_type.description
          fill_in 'Name', with: @activity_type.name
          click_on 'Create Activity type'

          assert_text 'Activity type was successfully created'
          click_on 'Back'
     end

     test 'should update Activity type' do
          visit activity_type_url(@activity_type)
          click_on 'Edit this activity type', match: :first

          fill_in 'Description', with: @activity_type.description
          fill_in 'Name', with: @activity_type.name
          click_on 'Update Activity type'

          assert_text 'Activity type was successfully updated'
          click_on 'Back'
     end

     test 'should destroy Activity type' do
          visit activity_type_url(@activity_type)
          click_on 'Destroy this activity type', match: :first

          assert_text 'Activity type was successfully destroyed'
     end
end
