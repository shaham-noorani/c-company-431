class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :class_year, :string
    add_column :users, :military_affiliation, :string
    add_column :users, :military_branch, :string
  end
end
