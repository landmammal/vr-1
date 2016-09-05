class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :phonenumber
      t.string :email
      t.string :contact_type
      t.string :message

      t.timestamps null: false
    end
  end
end
