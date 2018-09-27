class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column    :users, :withdrawals_enabled, :boolean, default: true
  end
end
