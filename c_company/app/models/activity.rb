class Activity < ApplicationRecord
  belongs_to :activity_type
  has_many :member_activities
  has_many :users, through: :member_activities
end
