# app/models/event.rb
class Event < ApplicationRecord
  has_many :member_events
  has_many :users, through: :member_events
  belongs_to :activity

  validates :name, presence: true, length: { maximum: 255 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location, presence: true, length: { maximum: 255 }
  validates :activity_id, presence: true
end
