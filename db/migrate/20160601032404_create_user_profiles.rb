class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :age
      t.string :education
      t.string :race
      t.string :company
      t.boolian :role

      t.timestamps null: false
    end
  end
end
