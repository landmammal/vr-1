class CreateRehearsals < ActiveRecord::Migration
  def change
    create_table :rehearsals do |t|
      t.integer :trainee_id, foreign_key: :user_id
      t.references :course, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.string :video_type
      t.string :token
      t.string :video_token
      t.text :script
      t.integer :approval_status
      t.boolean :submission

      t.timestamps null: false
    end
  end
end
