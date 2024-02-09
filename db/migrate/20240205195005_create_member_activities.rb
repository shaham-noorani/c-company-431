class CreateMemberActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :member_activities do |t|
      t.integer :user_id
      t.integer :activity_id
      t.datetime :date
      t.time :time_spent

      t.timestamps
    end
  end
end
