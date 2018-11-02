class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :btc_wallet, :string
    add_column :users, :ltc_wallet, :string
  end
end
