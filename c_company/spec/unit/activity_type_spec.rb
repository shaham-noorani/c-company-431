# spec/models/activity_type_spec.rb
require 'rails_helper'

RSpec.describe ActivityType, type: :model do
  subject do
    described_class.new(
      name: 'Running',
      description: 'Outdoor physical activity'
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a description' do
    subject.description = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid if name exceeds maximum length' do
    subject.name = 'a' * 256
    expect(subject).not_to be_valid
  end

  # Add more test cases based on your model validations

end
