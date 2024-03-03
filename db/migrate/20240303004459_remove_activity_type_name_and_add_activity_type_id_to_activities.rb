class RemoveActivityTypeNameAndAddActivityTypeIdToActivities < ActiveRecord::Migration[7.0]
  def change
    remove_column :activities, :activity_type_name

    add_column :activities, :activity_type_id, :integer
  end
end
