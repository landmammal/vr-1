class Prompt < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lesson, optional: true
  
  has_many :lesson_prompts
  has_many :lessons

  serialize :tags

  after_initialize :set_defaults, :if => :new_record?
  def set_defaults
    # self.refnum ||= "Pr-"+SecureRandom.hex(n=3)
  end
end
