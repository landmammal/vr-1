class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.references :lesson, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :explanation, index: true, foreign_key: true
      t.references :prompt, index: true, foreign_key: true
      t.references :model, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
