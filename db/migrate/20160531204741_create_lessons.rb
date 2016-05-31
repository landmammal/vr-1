class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.belongs_to :course, index: true, foreign_key: true
      t.belongs_to :topic, index: true, foreign_key: true
      t.string :lesson_title
      t.string :explanation
      t.string :prompt
      t.string :role_model
      t.string :performance
      t.text :explanation_script
      t.text :prompt_script
      t.text :model_script

      t.timestamps null: false
    end
  end
end
