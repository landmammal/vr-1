class TopicLesson < ActiveRecord::Base
  belongs_to :topic
  belongs_to :lesson
  accepts_nested_attributes_for :lesson
end
