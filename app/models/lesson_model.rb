class LessonModel < ApplicationRecord
  belongs_to :lesson, optional: true
  belongs_to :model, optional: true
  accepts_nested_attributes_for :lesson
end
