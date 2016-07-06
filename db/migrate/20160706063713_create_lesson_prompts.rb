class CreateLessonPrompts < ActiveRecord::Migration
  def change
    create_table :lesson_prompts do |t|
      t.references :lesson_id
      t.references :prompt_id

      t.timestamps null: false
    end
  end
end
