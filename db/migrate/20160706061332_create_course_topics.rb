class CreateCourseTopics < ActiveRecord::Migration
  def change
    create_table :course_topics do |t|
      t.references :course_id
      t.references :topic_id

      t.timestamps null: false
    end
  end
end
