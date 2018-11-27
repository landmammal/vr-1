class AddImageToPrompts < ActiveRecord::Migration[5.0]
  def change
    add_column :prompts, :image, :string
  end
end
