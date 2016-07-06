class TopicLesson < ActiveRecord::Base
  belongs_to :topic
  belongs_to :lesson
end
