class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      
      t.string :name
      t.string :description
      t.integer :instructor_id, foreign_key: :user_id
      t.string :privacy
      t.string :language
      t.string :website
      t.string :tags
      t.integer :member_limit
      t.string :group_type

      t.timestamps null: false
    end
  end
end
