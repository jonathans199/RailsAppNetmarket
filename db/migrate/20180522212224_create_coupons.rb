class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :uuid
      t.integer :user_id
      t.boolean :redeem, default: false
      t.integer :withdrawal_id
      t.timestamps
    end
  end
end
