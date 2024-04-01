class AddDeadlineToMemberActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :member_activities, :deadline, :datetime
  end
end
