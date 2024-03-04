# app/models/platoon.rb
class Platoon < ApplicationRecord
     has_many :users
     has_one :leader, class_name: 'User', foreign_key: 'leader_id'

     validates :name, presence: true, length: { maximum: 255 }
     validates :leader_id, presence: true
end
