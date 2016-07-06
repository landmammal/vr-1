class LessonModel < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :model
end
