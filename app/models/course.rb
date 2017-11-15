class Course < ApplicationRecord
  belongs_to :instructor, optional: true, class_name: 'User'

  # delete all registrations to this course
  has_many :course_registrations, dependent: :destroy
  has_many :users, through: :course_registrations

  has_many :course_topics, dependent: :destroy
  has_many :topics, through: :course_topics

  # delete all registrations to this course
  has_many :group_registrations, dependent: :destroy
  has_many :groups, through: :group_registrations

  has_many :rehearsals, dependent: :destroy

  def privacy!
  [[:Public, 0],[:Unpublished, 1],[:Paid, 2],[:Private, 3]]
  end

  def delete_associations
    @lessons = []
    # grab all lessons inside this course and delee them
    self.topics.each { |t| @lessons << Lesson.where(instructor_id: self.instructor, topic_id: t) }
  end


  def has_rehearsals?
    self.rehearsals.size > 0
  end

  def submitted_rehearsals
    self.rehearsals.where(submission: true)
  end
  def has_submitted_rehearsals?
    self.submitted_rehearsals.size > 0
  end

end