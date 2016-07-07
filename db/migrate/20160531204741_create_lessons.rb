class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.integer :status
      t.references :topic
      t.integer :instructor_id, foreign_key: :user_id

      t.timestamps null: false
    end
  end
end
