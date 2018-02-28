class Topic < ApplicationRecord
  include TopicsHelper

  belongs_to :instructor, optional: true, class_name: 'User'
  belongs_to :course, optional: true

  has_many :topic_lessons, dependent: :destroy
  has_many :lessons, through: :topic_lessons

  has_many :course_topics
  has_many :courses, through: :course_topics

  has_many :rehearsals, dependent: :destroy

  after_initialize :set_defaults, :if => :new_record?
  after_update :set_updates
  
  def set_defaults
    self.refnum ||= "To-"+SecureRandom.hex(n=3)
    self.title ||= "Unnamed Topic"
    self.privacy ||= 1
    self.approval_status ||= 1
  end

  def set_updates
    self.title ||= "Unnamed Topic"
  end

  def lessons_ready
    self.lessons_order.collect {|r| Lesson.find_by_refnum(r) }.compact.map{ |l| l if (l.privacy == 1 && l.approval_status == 1) }.compact
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

  def is_completed(user)
    self.lessons.map{ |x| x if topic_lesson_status(x) }.compact.size == user.rehearsals.map{ |x| x if (x.topic == self && x.approved? ) }.compact.size
  end

  def owner(user)
    self.instructor == user || user.role == 'admin'
  end

end