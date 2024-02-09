class CreateMemberEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :member_events do |t|
      t.integer :user_id
      t.integer :event_id
      t.datetime :date
      t.time :time_spent

      t.timestamps
    end
  end
end
