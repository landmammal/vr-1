class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.references :user
      t.references :lesson
      t.string :title
      t.string :token
      t.string :video_token
      t.string :script
      t.string :language
      t.string :privacy
      t.string :position_prior
      t.integer :watched

      t.timestamps null: false
    end
  end
end
