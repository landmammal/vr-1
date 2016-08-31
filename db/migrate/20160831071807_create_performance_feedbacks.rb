class CreatePerformanceFeedbacks < ActiveRecord::Migration
  def change
    create_table :performance_feedbacks do |t|
      t.belongs_to :rehearsal, index: true, foreign_key: true
      t.belongs_to :feedback, index: true, foreign_key: true
      t.boolean :approved, :default => false, :null => false

      t.timestamps null: false
    end
  end
end
