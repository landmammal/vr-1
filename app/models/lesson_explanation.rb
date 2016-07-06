class LessonExplanation < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :explanation
end
