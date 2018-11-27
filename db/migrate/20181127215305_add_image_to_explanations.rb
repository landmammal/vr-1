class AddImageToExplanations < ActiveRecord::Migration[5.0]
  def change
    add_column :explanations, :image, :string
  end
end
