class AddIndexOnCoupons < ActiveRecord::Migration[5.1]
  def change
    add_index :coupons, :user_id
    add_index :coupons, :withdrawal_id
  end
end
