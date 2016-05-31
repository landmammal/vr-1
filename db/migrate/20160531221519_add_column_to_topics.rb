class AddColumnToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :course, index: true, foreign_key: true
  end
end
