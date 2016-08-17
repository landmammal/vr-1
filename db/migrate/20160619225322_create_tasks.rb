class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user
      t.string :title
      t.text :description
      t.integer :priority
      t.boolean :flagged
      t.integer :reminder
      t.string :reminder_type
      t.date :due_date
      t.integer :status

      t.timestamps null: false
    end
  end
end
