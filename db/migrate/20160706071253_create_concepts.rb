class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.text :description
      t.references :lesson_id
      t.references :user_id

      t.timestamps null: false
    end
  end
end
