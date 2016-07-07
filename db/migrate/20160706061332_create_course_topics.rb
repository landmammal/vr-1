class CreateCourseTopics < ActiveRecord::Migration
  def change
    create_table :course_topics do |t|

      t.references :course
      t.references :topic

      t.timestamps null: false
    end
  end
end
