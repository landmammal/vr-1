class AddImageToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :models, :image, :string
  end
end
