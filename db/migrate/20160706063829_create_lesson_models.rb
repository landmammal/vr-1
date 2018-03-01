class CreateLessonModels < ActiveRecord::Migration
  def change
    create_table :lesson_models do |t|
      t.references :lesson
      t.references :model

      t.timestamps null: false
    end
  end
end
