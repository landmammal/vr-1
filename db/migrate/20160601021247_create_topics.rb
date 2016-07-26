  class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.string :tags
      t.integer :status
      t.references :course
      t.integer :instructor_id, foreign_key: :user_id
      t.string :privacy

      t.timestamps null: false
    end
  end
end
