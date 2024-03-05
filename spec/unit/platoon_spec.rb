# spec/models/platoon_spec.rb
require 'rails_helper'

RSpec.describe(Platoon, type: :model) do
     subject do
          described_class.new(
               name: 'Alpha Platoon',
               leader_id: leader.id
          )
     end

     let(:leader) do
          User.create(
               first_name: 'John',
               last_name: 'Doe',
               email: 'john@example.com',
               role: 'member',
               class_year: 'fish', # Adjust the value based on your needs
               military_affiliation: 'Air Force', # Adjust the value based on your needs
               military_branch: 'USAF' # Adjust the value based on your needs
          )
     end

     it 'is valid with valid attributes' do
          expect(subject).to(be_valid)
     end

     it 'is not valid without a name' do
          subject.name = nil
          expect(subject).not_to(be_valid)
     end

     it 'is not valid without a leader_id' do
          subject.leader_id = nil
          expect(subject).not_to(be_valid)
     end

     it 'has many users' do
          association = described_class.reflect_on_association(:users)
          expect(association.macro).to(eq(:has_many))
     end

     it 'has one leader' do
          association = described_class.reflect_on_association(:leader)
          expect(association.macro).to(eq(:has_one))
          expect(association.options[:class_name]).to(eq('User'))
          expect(association.options[:foreign_key]).to(eq('leader_id'))
     end

     # Add more test cases based on your model validations and associations
end
