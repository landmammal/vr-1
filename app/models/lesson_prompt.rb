class LessonPrompt < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :prompt
end
