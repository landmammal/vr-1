class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.text :description
      t.references :orig_lesson
      t.references :user

      t.timestamps null: false
    end
  end
end
