class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.integer :code
      t.integer :decimals
      t.timestamps
    end
  end
end
