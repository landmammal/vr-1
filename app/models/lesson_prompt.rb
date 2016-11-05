class LessonPrompt < ApplicationRecord
  belongs_to :lesson, optional: true
  belongs_to :prompt, optional: true
  accepts_nested_attributes_for :lesson
end
