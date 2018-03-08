class CreatePerformanceFeedbacks < ActiveRecord::Migration
  def change
    create_table :performance_feedbacks do |t|
      t.belongs_to :rehearsal, index: true, foreign_key: true
      t.belongs_to :feedback, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
