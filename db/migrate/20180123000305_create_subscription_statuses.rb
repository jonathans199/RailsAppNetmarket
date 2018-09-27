class CreateSubscriptionStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :subscription_statuses do |t|
      t.string :name
      t.integer :code
      t.text :description

      t.timestamps
    end
  end
end
