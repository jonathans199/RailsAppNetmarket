class AddAncestryToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ancestry, :string
    add_column :users, :ancestry_depth, :integer, :default => 0
    add_index :users, :ancestry
  end
end
