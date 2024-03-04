# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe(User, type: :model) do
     subject do
          described_class.new(
               first_name: 'John',
               last_name: 'Doe',
               email: 'john@example.com',
               role: 'pleb',
               platoon_id: platoon.id,
               class_year: 'Freshman', # Adjust the value based on your needs
               military_affiliation: 'Air Force', # Adjust the value based on your needs
               military_branch: 'USAF' # Adjust the value based on your needs
          )
     end

     let(:platoon) { Platoon.create(name: 'Alpha Platoon') }

     it 'is valid with valid attributes' do
          expect(subject).to(be_valid)
     end

     it 'is not valid without a first_name' do
          subject.first_name = nil
          expect(subject).not_to(be_valid)
     end

     it 'is not valid without a last_name' do
          subject.last_name = nil
          expect(subject).not_to(be_valid)
     end

     it 'is not valid without an email' do
          subject.email = nil
          expect(subject).not_to(be_valid)
     end

     it 'is not valid without a role' do
          subject.role = nil
          expect(subject).not_to(be_valid)
     end

     it 'belongs to a platoon' do
          association = described_class.reflect_on_association(:platoon)
          expect(association.macro).to(eq(:belongs_to))
          expect(association.options[:optional]).to(eq(true))
     end

     it 'has many member_activities' do
          association = described_class.reflect_on_association(:member_activities)
          expect(association.macro).to(eq(:has_many))
     end

     it 'has many activities through member_activities' do
          association = described_class.reflect_on_association(:activities)
          expect(association.macro).to(eq(:has_many))
          expect(association.options[:through]).to(eq(:member_activities))
     end

     # Add more test cases based on your model validations and associations
     describe 'instance methods' do
          let(:user) { User.new(first_name: 'joe', last_name: 'bob', role: 'admin', class_year: 'senior', military_branch: 'navy') }

          describe '#display_role' do
               it 'returns the display name for the role' do
                    expect(user.display_role).to(eq('Administrator'))
               end
          end

          describe '#display_year' do
               it 'returns the display name for the class year' do
                    expect(user.display_year).to(eq('Senior'))
               end
          end

          describe '#display_branch' do
               it 'returns the display name for the military branch' do
                    expect(user.display_branch).to(eq('Navy'))
               end
          end

          describe '#check_admin' do
               it 'returns true for an admin role' do
                    expect(user.check_admin).to(be_truthy)
               end

               it 'returns false for a non-admin role' do
                    user.role = 'pleb'
                    expect(user.check_admin).to(be_falsey)
               end
          end

          describe '#check_platoon_leader' do
               it 'returns true for a platoon_leader role' do
                    user.role = 'platoon_leader'
                    expect(user.check_platoon_leader).to(be_truthy)
               end

               it 'returns false for a non-platoon_leader role' do
                    user.role = 'admin'
                    expect(user.check_platoon_leader).to(be_falsey)
               end
          end
     end
end
