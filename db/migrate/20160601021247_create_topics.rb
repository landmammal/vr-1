class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.string :status
      t.references :lesson_id
      t.integer :instructor_id

      t.timestamps null: false
    end
  end
end
