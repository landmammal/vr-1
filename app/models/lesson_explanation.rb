class LessonExplanation < ApplicationRecord
  belongs_to :lesson
  belongs_to :explanation
  accepts_nested_attributes_for :lesson
end
