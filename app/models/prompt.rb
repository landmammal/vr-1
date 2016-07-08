class Prompt < ActiveRecord::Base
  has_many :lesson_prompts
  has_many :lessons

  serialize :tags
end
