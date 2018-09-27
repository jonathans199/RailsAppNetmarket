class CreateInversionProfitPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :inversion_profit_payments do |t|
      t.float :value

      t.timestamps
    end
  end
end
