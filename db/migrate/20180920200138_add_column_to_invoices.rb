class AddColumnToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :total_plans, :integer
  end
end
