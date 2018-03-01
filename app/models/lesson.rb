class Lesson < ApplicationRecord
  belongs_to :instructor, optional: true, class_name: 'User'
  belongs_to :topic, optional: true

  has_many :topic_lessons
  has_many :topics, through: :topic_lessons

  has_many :lesson_explanations, dependent: :destroy
  has_many :explanations, through: :lesson_explanations

  has_many :lesson_prompts, dependent: :destroy
  has_many :prompts, :through => :lesson_prompts

  has_many :lesson_models, dependent: :destroy
  has_many :models, :through => :lesson_models

  has_many :lesson_concepts, dependent: :destroy
  has_many :concepts, through: :lesson_concepts

  has_many :lesson_rehearsals
  has_many :rehearsals, through: :lesson_rehearsals

  after_initialize :set_defaults, :if => :new_record?
  after_create :set_create_def
  after_update :set_updates
  
  def set_defaults
    self.refnum ||= "Le-"+SecureRandom.hex(n=3)
    self.title ||= "Unnamed Lesson"
    self.privacy ||= 1
    self.approval_status ||= 1
  end

  def set_create_def
    self.topic.lessons_order << self.refnum
    self.topic.save
  end

  def set_updates
    self.title ||= "Unnamed Lesson"
  end


  def path
    "/courses/"+self.topic.course.id.to_s+"/topics/"+self.topic.id.to_s+"/lessons/"+self.id.to_s
  end

  def completed(user)
    status = false
    self.rehearsals.where(trainee_id: user.id).each do |rehearsal|
      if rehearsal.approved?
        # binding.pry
        return true
      end
    end
    # binding.pry
    status
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

  def has_rehearsals_from_user(user)
    self.rehearsals.where(trainee_id: user.id).size > 0
  end

  def has_new_rehearsals_from_user(user)
    self.rehearsals.map{ |x| x if ( x.trainee == user && x.new? ) }.compact.size > 0
  end

  
  def submitted_rehearsals_from_user(user)
    self.rehearsals.where(trainee_id: user.id).where(submission: true)
  end
  def has_submitted_rehearsals_from_user(user)
    self.submitted_rehearsals_from_user(user).size > 0
  end

  def completion_status(user)

    if self.has_rehearsals_from_user(user)
      
      if self.completed( user )
        status = "approved"
        message = "Lesson passed"
      elsif self.has_submitted_rehearsals_from_user(user)
        
        last_rehearsal = self.submitted_rehearsals_from_user(user).last
        
        if last_rehearsal && last_rehearsal.rejected?
          status = "rejected"
          message = "Please review your rehearsal"
        elsif last_rehearsal && last_rehearsal.has_feedback?
          status = "has_feedback"
          message = "You've got feedback"
        else
          status = "submitted"
          message = "Rehearsal Pending review by instructor"
        end
      
      else
        status = "has_rehearsal"
        message = "Rehearsals Recorded but not submitted"
      end

    else
      status = "new"
      message = "No rehearsals"
    end

    res = [status, message]
    res

  end

  def owner(user)
    self.instructor == user || user.role == 'admin'
  end

end
