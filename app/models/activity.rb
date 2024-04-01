# frozen_string_literal: true

# app/models/activity.rb
class Activity < ApplicationRecord
     belongs_to :activity_type, optional: true
     has_many :member_activities, dependent: :destroy
     has_many :users, through: :member_activities

     validates :name, presence: true, length: { maximum: 255 }
     validates :activity_type_id, presence: true
     validates :description, presence: true
end
