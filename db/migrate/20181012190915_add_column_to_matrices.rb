class AddColumnToMatrices < ActiveRecord::Migration[5.1]
  def change
    add_column :matrices, :plan_id, :integer
  end
end
