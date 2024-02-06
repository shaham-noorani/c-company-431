# spec/models/platoon_spec.rb
require 'rails_helper'

RSpec.describe Platoon, type: :model do
  let(:leader) { User.create(first_name: 'Leader', last_name: 'User', email: 'leader@example.com', role: 'leader') }

  subject do
    described_class.new(
      name: 'Alpha Platoon',
      leader_id: leader.id
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a leader_id' do
    subject.leader_id = nil
    expect(subject).not_to be_valid
  end

  it 'has many users' do
    association = described_class.reflect_on_association(:users)
    expect(association.macro).to eq :has_many
  end

  it 'has one leader' do
    association = described_class.reflect_on_association(:leader)
    expect(association.macro).to eq :has_one
    expect(association.options[:class_name]).to eq 'User'
    expect(association.options[:foreign_key]).to eq 'leader_id'
  end

  # Add more test cases based on your model validations and associations
end
