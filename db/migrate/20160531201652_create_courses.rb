class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_title
      t.text :description

      t.timestamps null: false
    end
  end
end
