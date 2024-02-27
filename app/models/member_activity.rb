# app/models/member_activity.rb
class MemberActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  validates :user, presence: true
  validates :activity, presence: true
  validates :date, presence: false
  validates :start_time, presence: false
  validates :end_time, presence: false

  # Remove any reference to time_spent

  # Add any additional model logic or methods based on your requirements
end
