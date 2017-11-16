class Rehearsal < ApplicationRecord
  belongs_to :trainee, optional: true, class_name: 'User'

  belongs_to :course, optional: true
  belongs_to :topic, optional: true
  belongs_to :lesson, optional: true
  belongs_to :group, optional: true

  has_many :lesson_rehearsals, dependent: :destroy
  has_many :lessons, through: :lesson_rehearsals

  has_many :performance_feedbacks, dependent: :destroy
  has_many :feedbacks, through: :performance_feedbacks, dependent: :destroy

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
end
