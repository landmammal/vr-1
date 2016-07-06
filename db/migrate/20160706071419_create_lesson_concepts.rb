class CreateLessonConcepts < ActiveRecord::Migration
  def change
    create_table :lesson_concepts do |t|
      t.references :concept_id
      t.references :lesson_id
      t.decimal :weight

      t.timestamps null: false
    end
  end
end
