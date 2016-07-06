class CreateLessonModels < ActiveRecord::Migration
  def change
    create_table :lesson_models do |t|
      t.references :lesson_id
      t.references :model_id

      t.timestamps null: false
    end
  end
end
