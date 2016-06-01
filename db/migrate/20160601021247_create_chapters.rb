class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.belongs_to :course, index: true, foreign_key: true
      t.string :chapter_title
      t.text :description

      t.timestamps null: false
    end
  end
end
