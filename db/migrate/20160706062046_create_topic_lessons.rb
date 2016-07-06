class CreateTopicLessons < ActiveRecord::Migration
  def change
    create_table :topic_lessons do |t|
      t.references :lesson_id
      t.references :topic_id

      t.timestamps null: false
    end
  end
end
