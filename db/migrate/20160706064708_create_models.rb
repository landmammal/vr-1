class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :user
      t.references :lesson
      t.string :title
      t.string :video_type
      t.string :token
      t.string :video_token
      t.string :script
      t.string :language
      t.integer :privacy
      t.integer :position_prior
      t.integer :watched
      t.integer :approval_status

      t.timestamps null: false
    end
  end
end
