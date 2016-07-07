class CreateCourseRegistrations < ActiveRecord::Migration
  def change
    create_table :course_registrations do |t|
      t.references :course
      t.references :user
      t.string :user_role

      t.timestamps null: false
    end
  end
end
