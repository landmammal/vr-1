class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :instructor, index: true, foreign_key: true
      t.references :coach, index: true, foreign_key: true
      t.references :rehearsal, index: true, foreign_key: true
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
