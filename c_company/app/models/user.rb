# app/models/user.rb
class User < ApplicationRecord
  belongs_to :platoon, optional: true
  has_many :member_events
  has_many :events, through: :member_events
  has_many :member_activities
  has_many :activities, through: :member_activities

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true
end
