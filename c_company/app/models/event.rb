class Event < ApplicationRecord
  has_many :member_events
  has_many :users, through: :member_events
  belongs_to :activity
end
