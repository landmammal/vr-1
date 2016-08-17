class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :title
      t.string :description
      t.integer :instructor_id, foreign_key: :user_id
      t.integer :privacy
      t.string :language
      t.string :website
      t.string :tags
      t.integer :member_limit
      t.integer :group_type
      t.text :note

      t.timestamps null: false
    end
  end
end
