class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.text  :description
      t.float :price
      t.float :fees
      t.integer :expiration_days
      t.float :daily_percent, default: 0
      t.boolean :subscription
      t.timestamps
    end
  end
end
