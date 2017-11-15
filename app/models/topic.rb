class Topic < ApplicationRecord
  belongs_to :instructor, optional: true, class_name: 'User'
  belongs_to :course, optional: true

  has_many :topic_lessons
  has_many :lessons, through: :topic_lessons

  has_many :course_topics
  has_many :courses, through: :course_topics

  has_many :rehearsals, dependent: :destroy

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