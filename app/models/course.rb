class Course < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User'
  has_many :course_registrations
  has_many :users, :through => :course_registrations

  serialize :tags

  has_many :course_topics
  has_many :alltopics, through: :course_topics, source: :topic
  has_many :topics, foreign_key: :origcourse_id
end
