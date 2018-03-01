class CourseTopic < ApplicationRecord
  belongs_to :topic, optional: true
  belongs_to :course, optional: true
  accepts_nested_attributes_for :topic
end
