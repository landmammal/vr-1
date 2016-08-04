class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|

      t.references :group, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :user_role
      t.boolean :approval_status

      t.timestamps null: false
    end
  end
end
