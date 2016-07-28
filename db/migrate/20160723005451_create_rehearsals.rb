class CreateRehearsals < ActiveRecord::Migration
  def change
    create_table :rehearsals do |t|
      t.integer :trainee_id, foreign_key: :user_id
      t.references :course, index: true, foreign_key: true
      t.references :progress, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.string :course_number
      t.string :video_type
      t.string :token
      t.string :video_token
      t.string :script
      t.string :status

      t.timestamps null: false
    end
  end
end
