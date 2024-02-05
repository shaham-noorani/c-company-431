# app/models/member_event.rb
class MemberEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user, presence: true
  validates :event, presence: true
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
