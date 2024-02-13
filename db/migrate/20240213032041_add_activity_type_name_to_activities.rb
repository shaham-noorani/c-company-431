class AddActivityTypeNameToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :activity_type_name, :string
  end
end
