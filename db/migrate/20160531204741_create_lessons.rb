class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.integer :topic_id
      t.integer :instructor_id, foreign_key: :user_id
      t.string :privacy
      t.string :lesson_type
      t.string :language
      t.string :approval_status
      t.string :succession
      t.string :lesson_level

      t.timestamps null: false
    end
  end
end
