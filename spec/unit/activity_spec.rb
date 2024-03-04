# spec/models/activity_spec.rb
require 'rails_helper'

RSpec.describe(Activity, type: :model) do
     subject do
          described_class.new(
               name: 'Morning Run',
               activity_type_id: activity_type.id,
               description: 'A refreshing morning jog'
          )
     end

     let(:activity_type) { ActivityType.create(name: 'Running', description: 'Outdoor physical activity') }

     it 'is valid with valid attributes' do
          expect(subject).to(be_valid)
     end

     it 'is not valid without a name' do
          subject.name = nil
          expect(subject).not_to(be_valid)
     end

     it 'is not valid without an activity_type_id' do
          subject.activity_type_id = nil
          expect(subject).not_to(be_valid)
     end

     it 'is not valid without a description' do
          subject.description = nil
          expect(subject).not_to(be_valid)
     end

     it 'belongs to an activity type' do
          association = described_class.reflect_on_association(:activity_type)
          expect(association.macro).to(eq(:belongs_to))
     end

     it 'has many member_activities' do
          association = described_class.reflect_on_association(:member_activities)
          expect(association.macro).to(eq(:has_many))
     end

     it 'has many users through member_activities' do
          association = described_class.reflect_on_association(:users)
          expect(association.macro).to(eq(:has_many))
          expect(association.options[:through]).to(eq(:member_activities))
     end

     # Add more test cases based on your model validations and associations
end
