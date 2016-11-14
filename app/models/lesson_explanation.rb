class LessonExplanation < ApplicationRecord
  belongs_to :lesson, optional: true
  belongs_to :explanation, optional: true
  accepts_nested_attributes_for :lesson
end
