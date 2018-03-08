class AddInstructorRatingToRehearsals < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :cover, :string
    add_column :rehearsals, :instructor_rating, :integer
    add_column :rehearsals, :self_rating, :integer
  end
end
