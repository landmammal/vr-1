class Prompt < ActiveRecord::Base
  has_many :lesson_prompts
  has_many :lessons

  has_many :original_lessons, :through => :lesson_prompts, foreign_key: :lesson_id

  serialize :tags
end
