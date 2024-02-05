# spec/models/member_event_spec.rb
require 'rails_helper'

RSpec.describe MemberEvent, type: :model do
  let(:user) { User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', role: 'member') }
  let(:activity_type) { ActivityType.create(name: 'Running', description: 'Outdoor physical activity') }
  let(:activity) { Activity.create(name: 'Morning Run', activity_type: activity_type, description: 'A refreshing morning jog') }
  let(:event) { Event.create(name: 'Team Building', start_time: Time.parse("09:00:00"), end_time: Time.parse("12:00:00"), activity: activity) }

  subject do
    described_class.new(
      user: user,
      event: event,
      date: DateTime.now,
      start_time: Time.parse("10:00:00"),
      end_time: Time.parse("11:30:00")
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an event' do
    subject.event = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a date' do
    subject.date = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without start_time' do
    subject.start_time = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without end_time' do
    subject.end_time = nil
    expect(subject).not_to be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it 'belongs to an event' do
    association = described_class.reflect_on_association(:event)
    expect(association.macro).to eq :belongs_to
  end

  # Add more test cases based on your model validations and associations
end
