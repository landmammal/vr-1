class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.integer :status
      t.integer :instructor_id, foreign_key: :user_id
      t.string :privacy

      t.timestamps null: false
    end
  end
end
