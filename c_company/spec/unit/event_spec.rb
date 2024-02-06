# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:activity_type) { ActivityType.create(name: 'Running', description: 'Outdoor physical activity') }
  let(:activity) { Activity.create(name: 'Morning Run', activity_type: activity_type, description: 'A refreshing morning jog') }

  subject do
    described_class.new(
      name: 'Morning Run Event',
      start_time: DateTime.now,
      end_time: DateTime.now + 1.hour,
      location: 'Park',
      description: 'Join us for a morning run event!',
      activity_id: activity.id
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a start_time' do
    subject.start_time = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an end_time' do
    subject.end_time = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a location' do
    subject.location = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an activity_id' do
    subject.activity_id = nil
    expect(subject).not_to be_valid
  end

  it 'belongs to an activity' do
    association = described_class.reflect_on_association(:activity)
    expect(association.macro).to eq :belongs_to
  end

  it 'has many member_events' do
    association = described_class.reflect_on_association(:member_events)
    expect(association.macro).to eq :has_many
  end

  it 'has many users through member_events' do
    association = described_class.reflect_on_association(:users)
    expect(association.macro).to eq :has_many
    expect(association.options[:through]).to eq :member_events
  end

  # Add more test cases based on your model validations and associations
end
