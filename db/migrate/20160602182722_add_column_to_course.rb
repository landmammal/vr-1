class AddColumnToCourse < ActiveRecord::Migration
  def change
    add_reference :courses, :user_id, index: true, foreign_key: true
  end
end
