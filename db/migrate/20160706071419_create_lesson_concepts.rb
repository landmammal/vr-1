class CreateLessonConcepts < ActiveRecord::Migration
  def change
    create_table :lesson_concepts do |t|
      t.references :concept
      t.references :lesson
      t.decimal :weight

      t.timestamps null: false
    end
  end
end
