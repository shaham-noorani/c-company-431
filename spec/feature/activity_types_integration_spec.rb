# spec/features/activity_types_integration_spec.rb

require 'rails_helper'

RSpec.describe 'Creating an activity type', type: :feature do
  scenario 'valid inputs' do
    visit new_activity_type_path
    fill_in 'activity_type[name]', with: 'Running'
    fill_in 'activity_type[description]', with: 'Run for exercise'
    click_on 'Create Activity type'
    visit activity_types_path
    expect(page).to have_content('Running')
    expect(page).to have_content('Run for exercise')
  end

  scenario 'blank name (rainy-day scenario)' do
    visit new_activity_type_path
    fill_in 'activity_type[name]', with: ''
    fill_in 'activity_type[description]', with: 'Run for exercise'
    click_on 'Create Activity type'
    expect(page).to have_content("Name can't be blank")
  end

  scenario 'blank description (rainy-day scenario)' do
    visit new_activity_type_path
    fill_in 'activity_type[name]', with: 'Running'
    fill_in 'activity_type[description]', with: ''
    click_on 'Create Activity type'
    expect(page).to have_content("Description can't be blank")
  end
end