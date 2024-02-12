class AddCompletedToMemberActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :member_activities, :completed, :boolean
  end
end
