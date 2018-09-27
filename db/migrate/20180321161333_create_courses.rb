class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string  :uuid
      t.string  "title"
      t.string  "category_id"
      t.text    "description"
      t.string  "language"
      t.integer "user_id"
      t.attachment :avatar
      t.timestamps
    end
  end
end
