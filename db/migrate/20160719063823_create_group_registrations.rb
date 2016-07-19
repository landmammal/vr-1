class CreateGroupRegistrations < ActiveRecord::Migration
  def change
    create_table :group_registrations do |t|
      t.references :course, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
