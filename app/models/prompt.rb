class Prompt < ApplicationRecord
  # mounting image uploader
  mount_uploader :image, ImageUploader
  
  belongs_to :user, optional: true
  belongs_to :lesson, optional: true

  # has_many :lesson_prompts
  # belongs_to :lessons

  serialize :tags

  after_initialize :set_defaults, :if => :new_record?
  def set_defaults
    self.refnum ||= "Pr-"+SecureRandom.hex(n=3)
  end
end
