class CreateLessonRehearsals < ActiveRecord::Migration
  def change
    create_table :lesson_rehearsals do |t|
      t.belongs_to :rehearsal, index: true, foreign_key: true
      t.belongs_to :lesson, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
