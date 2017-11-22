class AddCstatusToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :cstatus, :integer
  end
end
