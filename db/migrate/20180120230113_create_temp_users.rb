class CreateTempUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :temp_users do |t|
      t.string :uuid
      t.string :parent_uuid
      t.string :username
      t.boolean :right, default: false
      t.boolean :active
      t.boolean :admin, default: false
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :phone
      t.string :document
      t.string :country
      t.string :city
      t.string :address
      t.string :about
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.datetime :last_login
      t.timestamps
    end
  end
end
