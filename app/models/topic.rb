class Topic < ActiveRecord::Base
  # belongs_to :user
  has_many :topic_lessons
  has_many :lessons, :through => :topic_lessons

  serialize :tags

  has_many :course_topics
  has_many :courses, :through => :course_topics
end
