class Platoon < ApplicationRecord
  has_many :users
  has_one :leader, class_name: 'User', foreign_key: 'leader_id'
end
