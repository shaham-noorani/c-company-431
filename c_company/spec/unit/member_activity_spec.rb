# spec/models/member_activity_spec.rb
require 'rails_helper'

RSpec.describe(MemberActivity, type: :model) do
  subject do
    described_class.new(
      user: user,
      activity: activity,
      date: DateTime.now,
      start_time: Time.parse('08:00:00'),
      end_time: Time.parse('08:30:00')
    )
  end

  let(:user) do
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
  let(:activity_type) { ActivityType.create(name: 'Running', description: 'Outdoor physical activity') }
  let(:activity) { Activity.create(name: 'Morning Run', activity_type: activity_type, description: 'A refreshing morning jog') }

  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without an activity' do
    subject.activity = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without a date' do
    subject.date = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without start_time' do
    subject.start_time = nil
    expect(subject).not_to(be_valid)
  end

  it 'is not valid without end_time' do
    subject.end_time = nil
    expect(subject).not_to(be_valid)
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to(eq(:belongs_to))
  end

  it 'belongs to an activity' do
    association = described_class.reflect_on_association(:activity)
    expect(association.macro).to(eq(:belongs_to))
  end

  # Add more test cases based on your model validations and associations
end
