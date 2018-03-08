class Rehearsal < ApplicationRecord
  after_update :send_submitted_email, if: :submission_changed?
  after_update :send_approval_email, if: :approval_status_changed?

  belongs_to :trainee, optional: true, class_name: 'User'

  belongs_to :course, optional: true
  belongs_to :topic, optional: true
  belongs_to :lesson, optional: true
  belongs_to :group, optional: true

  # has_many :lesson_rehearsals, dependent: :destroy
  # has_many :lessons, through: :lesson_rehearsals

  # has_many :performance_feedbacks, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  has_many :review_requests
  has_many :peer_reviews, through: :review_requests, dependent: :destroy

  after_initialize :set_defaults, :if => :new_record?
  def set_defaults
    self.refnum ||= "Re-"+SecureRandom.hex(n=3)
  end

  def submitted?
    self.submission != nil || self.submission
  end

  def approved?
    self.approval_status == 1
  end

  def rejected?
    self.approval_status == 2
  end

  def has_feedback?
    self.feedbacks.size > 0
  end

  def new?
    self.submitted? && ( !self.approved? && !self.rejected? && !self.has_feedback? )
  end

  def check_status
    
    if self.new?
      status="new_rehearsal"
    elsif self.approved?
      status="approved_rehearsal"
    elsif self.rejected?
      status="rejected_rehearsal"
    elsif self.has_feedback?
      status="rehearsal_with_feedback"
    end

    status
  end

  def send_approval_email
    self.approval_status == 1 ? message = "Your performance was approved!" : message = "You need to tweak a few things."
    AdminMailer.lesson_complete_notice(self.trainee, self.approval_status, message, self.lesson).deliver_later if ( self.approved? || self.rejected? )
  end

  def send_submitted_email
    AdminMailer.rehearsal_sent(self).deliver_later if self.submitted?
  end

end
