class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :instructor, index: true, foreign_key: true
      t.integer :coach, index: true, foreign_key: true
      t.integer :review_status
      t.integer :concept_review
      t.text :notes
      t.string :token
      t.string :video_token
      t.boolean :approved
      t.string :video_type

      t.timestamps null: false
    end
  end
end
