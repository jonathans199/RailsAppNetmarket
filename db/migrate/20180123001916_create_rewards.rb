class CreateRewards < ActiveRecord::Migration[5.1]
  def change
    create_table :rewards do |t|
      t.string :uuid
      t.float   :value
      t.integer :reward_type_id
      t.integer :reward_status_id
      t.integer :currency_id
      t.integer :user_id
      t.integer :subscription_id

      t.timestamps
    end
  end
end
