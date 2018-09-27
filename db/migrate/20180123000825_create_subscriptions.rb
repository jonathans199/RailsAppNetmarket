class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :uuid
      t.integer :user_id
      t.integer :plan_id
      t.integer :invoice_id
      t.integer :subscription_status_id
      t.datetime :expiration

      t.timestamps
    end
  end
end
