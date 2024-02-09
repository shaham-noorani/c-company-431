class CreatePlatoons < ActiveRecord::Migration[7.0]
  def change
    create_table :platoons do |t|
      t.string :name
      t.integer :leader_id

      t.timestamps
    end
  end
end
