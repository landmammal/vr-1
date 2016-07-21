class CreateExplanations < ActiveRecord::Migration
  def change
    create_table :explanations do |t|
      t.references :user
      t.references :lesson
      t.string :title
      t.string :token
      t.string :video_token
      t.string :script
<<<<<<< HEAD
      t.string :position
=======
      t.string :position_prior
      t.string :privacy
      t.string :language
>>>>>>> 1773b4b64c2146dfa47a8ecb272151fe31da7553

      t.timestamps null: false
    end
  end
end
