class CreateExplanations < ActiveRecord::Migration
  def change
    create_table :explanations do |t|
      t.references :user
      t.references :lesson
      t.string :token
      t.string :video_token
      t.string :script

      t.timestamps null: false
    end
  end
end
