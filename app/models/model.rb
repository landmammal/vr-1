class Model < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lesson, optional: true
  
  has_many :lesson_models
  has_many :lessons, through: :lesson_models

  serialize :tags

  after_initialize :set_defaults, :if => :new_record?
  def set_defaults
    self.refnum ||= "Mo-"+SecureRandom.hex(n=3)
  end
end
