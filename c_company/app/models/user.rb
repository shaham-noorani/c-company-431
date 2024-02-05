class User < ApplicationRecord
  belongs_to :platoon, optional: true
  has_many :member_events
  has_many :events, through: :member_events
  has_many :member_activities
  has_many :activities, through: :member_activities
end
