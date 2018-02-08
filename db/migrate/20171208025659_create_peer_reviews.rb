class CreatePeerReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :peer_reviews do |t|
      t.belongs_to :review_request
      t.string :token
      t.string :video_token
      t.string :notes
      t.integer :rating

      t.timestamps
    end
  end
end
