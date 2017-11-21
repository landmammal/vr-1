class AddAccessCodeToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :access_code, :string
  end
end
