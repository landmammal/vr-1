class CreateReviewRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :review_requests do |t|
      t.string :person_name
      t.string :person_email
      t.belongs_to :rehearsal
      t.string :hash_key

      t.timestamps
    end
  end
end
