class Prompt < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lesson, optional: true
  
  has_many :lesson_prompts
  has_many :lessons

  serialize :tags
end
