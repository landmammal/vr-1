class Course < ApplicationRecord
  belongs_to :instructor, optional: true, class_name: 'User'

  has_many :course_registrations
  has_many :users, through: :course_registrations

  has_many :course_topics
  has_many :topics, through: :course_topics

  has_many :group_registrations
  has_many :groups, through: :group_registrations

  has_many :rehearsals

  def privacy!
  	[[:Public, 0],[:Unpublished, 1],[:Paid, 2],[:Private, 3]]
  end

  def delete_associations
  # delete all registrations to this course
  CourseRegistration.where(course_id: self).delete_all
  GroupRegistration.where(course_id: self).delete_all

  # grab all rehearsals inside this course
  rehearsals = Rehearsal.where(course_id: self)

  # if there is any delete them from performance feedback table
  rehearsals.each { |r| PerformanceFeedback.where(rehearsal_id: r).delete_all } if rehearsals.any?

  # grab all lessons inside this course
  self.topics.each { |t| @lessons = Lesson.where(instructor_id: self.instructor, topic_id: t) }

  # check if there are any and if so, delete all rehearsals attach to them on lessons rehearsals table
  @lessons.each { |l| LessonRehearsal.where(lesson_id: l,).delete_all } if @lessons.any?

  # now that the rehearsals is disconnected from other tables
  # we can delete all rehearsals in this course
  # and be able to delete the course
  Rehearsal.where(course_id: self).delete_all
  end
end