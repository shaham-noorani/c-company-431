# frozen_string_literal: true

# app/models/activity_type.rb
class ActivityType < ApplicationRecord
     has_many :activity, dependent: :destroy

     validates :name, presence: true, length: { maximum: 255 }
     validates :description, presence: true
end
