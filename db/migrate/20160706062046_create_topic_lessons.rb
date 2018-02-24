class CreateTopicLessons < ActiveRecord::Migration
  def change
    create_table :topic_lessons do |t|
      t.references :lesson
      t.references :topic

      t.timestamps null: false
    end
  end
end
