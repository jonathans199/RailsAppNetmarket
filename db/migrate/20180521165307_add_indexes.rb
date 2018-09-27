class AddIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :uuid
    add_index :currencies, :code
    add_index :invoice_statuses, :code
    add_index :invoices, :wallet
    add_index :invoices, :user_id
    add_index :invoices, :temp_user_id
    add_index :points, :user_id
    add_index :reward_statuses, :code
    add_index :reward_types, :code
    add_index :rewards, :user_id
    add_index :rewards, :subscription_id
    add_index :subscription_statuses, :code
    add_index :subscriptions, :user_id
    add_index :temp_users, :uuid
    add_index :vaults, :user_id
    add_index :withdrawal_statuses, :code
    add_index :withdrawal_types, :code
    add_index :withdrawals, :user_id
  end
end
