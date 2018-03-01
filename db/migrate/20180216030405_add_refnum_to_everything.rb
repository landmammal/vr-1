class AddRefnumToEverything < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :color, :string
    add_column :courses, :requirements, :text
    add_column :courses, :short_desc, :text
    add_column :courses, :topics_order, :string ,array: true, default: []
    add_column :topics, :lessons_order, :string ,array: true, default: []
    
    # TODO: REF NUMBERS
    add_column :courses, :refnum, :string
    add_column :topics, :refnum, :string
    add_column :lessons, :refnum, :string
    add_column :concepts, :refnum, :string
    add_column :explanations, :refnum, :string
    add_column :prompts, :refnum, :string
    add_column :models, :refnum, :string
    add_column :feedbacks, :refnum, :string
    add_column :rehearsals, :refnum, :string
    add_column :users, :auth_token, :string
  end
end
