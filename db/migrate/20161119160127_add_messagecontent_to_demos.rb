class AddMessagecontentToDemos < ActiveRecord::Migration[5.0]
  def change
    add_column :demos, :messagecontent, :text
  end
end
