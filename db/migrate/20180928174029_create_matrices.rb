class CreateMatrices < ActiveRecord::Migration[5.1]
  def change
    create_table :matrices do |t|
      t.string :uuid
      t.boolean :reedemed, default: false
      t.text :users
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
