class CreateLessonPrompts < ActiveRecord::Migration
  def change
    create_table :lesson_prompts do |t|
      t.references :lesson
      t.references :prompt

      t.timestamps null: false
    end
  end
end
