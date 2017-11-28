class AddFirstContactToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_contact, :boolean, :default => true
  end
end
