# frozen_string_literal: true

# app/models/platoon.rb
class Platoon < ApplicationRecord
     has_many :users, dependent: :destroy
     has_one :leader, class_name: 'User', foreign_key: 'leader_id', inverse_of: :platoon

     validates :name, presence: true, length: { maximum: 255 }
     validates :leader_id, presence: true
end
