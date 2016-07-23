class LessonRehearsal < ActiveRecord::Base
  belongs_to :rehearsal
  belongs_to :lesson
end
