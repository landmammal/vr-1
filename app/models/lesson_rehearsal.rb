class LessonRehearsal < ApplicationRecord
  belongs_to :rehearsal
  belongs_to :lesson
  accepts_nested_attributes_for :lesson
end
