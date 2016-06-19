class AddIndexToPractices < ActiveRecord::Migration
  def change
    add_index :practices, [:user_id, :lesson_id], unique: true
  end
end
