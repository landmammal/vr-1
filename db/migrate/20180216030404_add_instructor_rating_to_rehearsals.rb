class AddInstructorRatingToRehearsals < ActiveRecord::Migration[5.0]
  def change
    add_column :rehearsals, :instructor_rating, :integer
    add_column :rehearsals, :self_rating, :integer
  end
  
  def change
    add_column :courses, :color, :string
    add_column :courses, :requirements, :text
    add_column :courses, :short_desc, :text
    add_column :courses, :topics_order, :array
    add_column :topics, :lessons_order, :array
  end
end
