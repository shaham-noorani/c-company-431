class RemoveTimeSpentAndAddStartTimeEndTimeToMemberEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :member_events, :time_spent
    add_column :member_events, :start_time, :time
    add_column :member_events, :end_time, :time
  end
end
