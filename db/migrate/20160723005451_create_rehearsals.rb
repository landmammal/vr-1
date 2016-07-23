class CreateRehearsals < ActiveRecord::Migration
  def change
    create_table :rehearsals do |t|
      t.references :course, index: true, foreign_key: true
      t.references :progress, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.integer :course_number
      t.string :token
      t.string :video_token

      t.timestamps null: false
    end
  end
end
