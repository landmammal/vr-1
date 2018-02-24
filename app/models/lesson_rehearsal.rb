class LessonRehearsal < ApplicationRecord
  belongs_to :rehearsal, optional: true
  belongs_to :lesson, optional: true
  accepts_nested_attributes_for :lesson
end
