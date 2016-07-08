class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.text :description
      t.integer :lesson_id
      t.references :user

      t.timestamps null: false
    end
  end
end
