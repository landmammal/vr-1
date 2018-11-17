class CreateDemos < ActiveRecord::Migration
  def change
    create_table :demos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.date :date
      t.integer :contacted
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
