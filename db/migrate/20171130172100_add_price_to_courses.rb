class AddPriceToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :price, :integer
  end
end
