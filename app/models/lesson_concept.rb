class LessonConcept < ApplicationRecord
  belongs_to :concept
  belongs_to :lesson
  accepts_nested_attributes_for :lesson
end
