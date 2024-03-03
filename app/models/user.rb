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

  # New column validations
  validates :class_year, length: { maximum: 255 }
  validates :military_affiliation, length: { maximum: 255 }
  validates :military_branch, length: { maximum: 255 }

  ROLE_DISPLAY_NAMES = {
    'admin' => 'Administrator',
    'commander' => 'Commander',
    'executive' => 'Executive',
    'first_sergeant' => 'First Sergeant',
    'platoon_leader' => 'Platoon Leader',
    'platoon_sergeant' => 'Platoon Sergeant',
    'team_leader' => 'Team Leader',
    'squad_leader' => 'Squad Leader',
    'pleb' => 'Member' 
  }.freeze
  YEAR_DISPLAY_NAMES = {
    'freshman' => 'Freshman',
    'sophomore' => 'Sophomore',
    'junior' => 'Junior',
    'senior' => 'Senior',
    'none' => 'None'
  }.freeze
  BRANCH_DISPLAY_NAMES = {
    'army' => 'Army',
    'navy' => 'Navy',
    'air_force' => 'Air Force',
    'marine_corps' => 'Marine Corps',
    'space_force' => 'Space Force',
    'national_guard' => 'National Guard',
    'none' => 'None'
  }.freeze

  def display_role
    if(role.nil?)
      return ''
    else
      ROLE_DISPLAY_NAMES[role] || role.titleize
    end
  end
  def display_year
    if(class_year.nil?)
      return ''
    else
      YEAR_DISPLAY_NAMES[class_year] || class_year.titleize
    end
  end
  def display_branch
    if(military_branch.nil?)
      return ''
    else
      BRANCH_DISPLAY_NAMES[military_branch] || military_branch.titleize
    end
  end
  def check_admin
    Rails.logger.debug role
    return ["admin", "first_sergeant", "commander", "executive"].include?(role)
  end
  def check_platoon_leader
    Rails.logger.debug role
    return ["platoon_leader", "platoon_sergeant"].include?(role)
  end
end
