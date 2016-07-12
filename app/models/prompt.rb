class Prompt < ActiveRecord::Base
  belongs_to :user
  
  has_many :lesson_prompts
  has_many :lessons

  serialize :tags
end
