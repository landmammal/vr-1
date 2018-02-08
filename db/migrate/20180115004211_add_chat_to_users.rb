class AddChatToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :chat, :string
  end
end
