class CreateLessonExplanations < ActiveRecord::Migration
  def change
    create_table :lesson_explanations do |t|
      t.references :lesson
      t.references :explanation

      t.timestamps null: false
    end
  end
end
