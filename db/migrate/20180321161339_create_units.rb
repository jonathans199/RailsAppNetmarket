class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string  :uuid
      t.string  "title"
      t.text    "description"
      t.string  "duration"
      t.text    "embed_code"
      t.integer "course_id"
      t.attachment :avatar
      t.timestamps
    end
  end
end
