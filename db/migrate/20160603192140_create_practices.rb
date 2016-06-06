class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :token
      t.string :video_token
      t.boolean :completed, default: false
      t.references :user, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
