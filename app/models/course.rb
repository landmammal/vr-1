class Course < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User'
  has_many :course_registrations
  has_many :users, :through => :course_registrations

  serialize :tags

  has_many :course_topics
  has_many :original_topics, :through => :course_topics, foreign_key: :course_id
  has_manny :topics
end
