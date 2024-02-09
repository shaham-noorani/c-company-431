# app/models/member_activity.rb
class MemberActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :user, presence: true
  validates :activity, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  # Remove any reference to time_spent

  # Add any additional model logic or methods based on your requirements
end
