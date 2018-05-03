class Topic < ApplicationRecord
  include TopicsHelper

  belongs_to :instructor, optional: true, class_name: 'User'
  belongs_to :course, optional: true

  has_many :lessons, dependent: :destroy
  belongs_to :courses

  has_many :rehearsals, dependent: :destroy

  after_initialize :set_defaults, :if => :new_record?
  after_create :set_create_defs
  after_update :set_updates
  
  def set_defaults
    self.refnum ||= "To-"+SecureRandom.hex(n=3)
    self.title ||= "Unnamed Topic"
    self.privacy ||= 1
    self.approval_status ||= 1
  end

  def set_create_defs
    self.lessons.create( instructor_id: self.instructor_id )
    self.save
    self.course.topics_order << self.refnum
    self.course.save
  end

  def set_updates
    self.title ||= "Unnamed Topic"
  end

  def lessons_ready(user)
    lessons = self.lessons_order.collect {|r| Lesson.find_by_refnum(r) }.compact
    if self.owner(user)
      lessons
    else
      lessons.map{ |l| l if (l.privacy == 1 && l.approval_status == 1) }.compact
    end
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