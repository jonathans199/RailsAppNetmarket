class AddColumnsToInversionProfitPayment < ActiveRecord::Migration[5.1]
  def up
    add_column :inversion_profit_payments, :value2, :float
    add_column :inversion_profit_payments, :value3, :float
    add_column :inversion_profit_payments, :value4, :float
    add_column :inversion_profit_payments, :value5, :float
    add_column :inversion_profit_payments, :value6, :float
    rename_column :inversion_profit_payments, :value, :value1
  end

  def down
    remove_column :inversion_profit_payments, :value2
    remove_column :inversion_profit_payments, :value3
    remove_column :inversion_profit_payments, :value4
    remove_column :inversion_profit_payments, :value5
    remove_column :inversion_profit_payments, :value6
    rename_column :inversion_profit_payments, :value1, :value
  end
end
