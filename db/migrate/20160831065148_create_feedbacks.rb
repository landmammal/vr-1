class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.references :rehearsal
      t.integer :rehearsal_rating
      t.integer :concept_review
      t.text :notes
      t.string :token
      t.string :video_token
      t.boolean :approved
      t.boolean :viewed_by_user
      t.string :video_type

      t.timestamps null: false
    end
  end
end
