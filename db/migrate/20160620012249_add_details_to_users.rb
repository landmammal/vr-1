class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :string
    add_column :users, :banner, :string
  end
end
