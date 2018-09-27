class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uuid
      t.string :parent_uuid
      t.string :sponsor_uuid
      t.boolean :right
      t.boolean :active
      t.boolean :left_son
      t.string :username
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :document
      t.string :country
      t.string :city
      t.string :address
      t.datetime :confirmed_at
      t.datetime :last_login
      t.attachment :avatar
      t.timestamps
    end
  end
end
