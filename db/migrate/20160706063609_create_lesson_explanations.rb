class CreateLessonExplanations < ActiveRecord::Migration
  def change
    create_table :lesson_explanations do |t|
      t.references :lesson_id
      t.references :explanation_id

      t.timestamps null: false
    end
  end
end
