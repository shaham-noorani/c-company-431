class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :activity_type_id
      t.text :description

      t.timestamps
    end
  end
end
