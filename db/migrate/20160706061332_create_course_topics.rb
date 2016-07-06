class CreateCourseTopics < ActiveRecord::Migration
  def change
    create_table :course_topics do |t|
      t.references :course_id, index: true, foreign_key: true
      t.references :topic_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
