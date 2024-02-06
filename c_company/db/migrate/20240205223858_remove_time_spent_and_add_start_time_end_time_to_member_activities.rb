class RemoveTimeSpentAndAddStartTimeEndTimeToMemberActivities < ActiveRecord::Migration[7.0]
  def change
    remove_column :member_activities, :time_spent
    add_column :member_activities, :start_time, :time
    add_column :member_activities, :end_time, :time
  end
end
