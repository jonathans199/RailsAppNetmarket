class CreateVaults < ActiveRecord::Migration[5.1]
  def change
    create_table :vaults do |t|
      t.integer :user_id
      t.float   :amount, default: 0
      t.float   :total_rewards, default: 0
      t.float   :total_withdrawals, default: 0
      t.timestamps
    end
  end
end
