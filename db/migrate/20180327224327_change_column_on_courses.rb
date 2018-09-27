class ChangeColumnOnCourses < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :category_id
    add_column    :courses, :category_id, :integer
  end
end
