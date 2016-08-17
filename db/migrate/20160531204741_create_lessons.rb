class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.integer :topic_id
      t.integer :instructor_id, foreign_key: :user_id
      t.integer :privacy
      t.integer :lesson_type
      t.string :language
      t.integer :approval_status
      t.integer :succession
      t.integer :lesson_level

      t.timestamps null: false
    end
  end
end
