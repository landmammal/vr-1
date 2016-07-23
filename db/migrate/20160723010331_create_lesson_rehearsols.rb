class CreateLessonRehearsols < ActiveRecord::Migration
  def change
    create_table :lesson_rehearsols do |t|
      t.belongs_to :rehearsol, index: true, foreign_key: true
      t.belongs_to :lesson, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
