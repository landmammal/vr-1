class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.references :instructor_id, foreign_key: :user_id
      t.string :privacy

      t.timestamps null: false
    end
  end
end
