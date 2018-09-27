class CreateWithdrawals < ActiveRecord::Migration[5.1]
  def change
    create_table :withdrawals do |t|
      t.string :uuid
      t.integer :user_id
      t.integer :withdrawal_type_id
      t.integer :withdrawal_status_id
      t.float :settle
      t.float :value
      t.float :fees
      t.text :comments
      t.string :wallet
      t.integer :currency_id
      t.string :txid

      t.timestamps
    end
  end
end
