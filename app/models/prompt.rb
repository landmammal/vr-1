class Prompt < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  
  has_many :lesson_prompts
  has_many :lessons

  serialize :tags
end
