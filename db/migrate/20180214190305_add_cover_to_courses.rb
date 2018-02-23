class AddCoverToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :cover, :string
  end
end
