class Lesson < ApplicationRecord
  belongs_to :instructor, optional: true, class_name: 'User'
  belongs_to :topic, optional: true

  has_many :topic_lessons
  has_many :topics, through: :topic_lessons

  has_many :lesson_explanations
  has_many :explanations, through: :lesson_explanations

  has_many :lesson_prompts
  has_many :prompts, :through => :lesson_prompts

  has_many :lesson_models
  has_many :models, :through => :lesson_models

  has_many :lesson_concepts
  has_many :concepts, through: :lesson_concepts

  has_many :lesson_rehearsals
  has_many :rehearsals, through: :lesson_rehearsals

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

  
  def submitted_rehearsals_from_user(user)
    self.rehearsals.where(trainee_id: user.id).where(submission: true)
  end
  def has_submitted_rehearsals_from_user(user)
    self.submitted_rehearsals_from_user(user).size > 0
  end

end
