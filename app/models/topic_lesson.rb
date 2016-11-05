class TopicLesson < ApplicationRecord
  belongs_to :topic, optional: true
  belongs_to :lesson, optional: true
  accepts_nested_attributes_for :lesson
end
