# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe(User, type: :model) do
  subject do
    described_class.new(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      role: 'member',
      platoon_id: platoon.id,
      class_year: '2024', # Adjust the value based on your needs
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

  it 'has many member_events' do
    association = described_class.reflect_on_association(:member_events)
    expect(association.macro).to(eq(:has_many))
  end

  it 'has many events through member_events' do
    association = described_class.reflect_on_association(:events)
    expect(association.macro).to(eq(:has_many))
    expect(association.options[:through]).to(eq(:member_events))
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
end
