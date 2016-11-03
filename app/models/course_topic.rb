class CourseTopic < ApplicationRecord
  belongs_to :topic
  belongs_to :course
  accepts_nested_attributes_for :topic
end
