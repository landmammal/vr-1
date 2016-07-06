class LessonConcept < ActiveRecord::Base
  belongs_to :concept
  belongs_to :lesson
end
