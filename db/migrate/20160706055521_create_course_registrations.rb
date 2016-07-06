class CreateCourseRegistrations < ActiveRecord::Migration
  def change
    create_table :course_registrations do |t|
      t.references :course_id
      t.references :user_id
      t.string :user_role

      t.timestamps null: false
    end
  end
end
