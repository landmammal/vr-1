class Prompt < ActiveRecord::Base
  has_many :lesson_prompts
  has_many :lessons, through: :lesson_prompts

  serialize :tags
end
