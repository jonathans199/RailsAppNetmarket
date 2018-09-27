class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :uuid
      t.float :price
      t.float :fees
      t.string :wallet
      t.string :txid
      t.integer :invoice_status_id
      t.integer :currency_id
      t.integer :user_id
      t.integer :temp_user_id
      t.integer :plan_id

      t.timestamps
    end
  end
end
