class LessonConcept < ApplicationRecord
  belongs_to :concept, optional: true
  belongs_to :lesson, optional: true
  accepts_nested_attributes_for :lesson
end
