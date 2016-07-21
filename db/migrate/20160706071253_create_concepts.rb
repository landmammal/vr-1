class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.text :description
      t.references :lesson
      t.references :user
      t.string :privacy
      t.string :language
      
      t.timestamps null: false
    end
  end
end
