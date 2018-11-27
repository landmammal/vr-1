class Explanation < ApplicationRecord
  # mounting image uploader
  mount_uploader :image, ImageUploader

  belongs_to :user, optional: true
  belongs_to :lesson, optional: true

  # has_many :lesson_explanations
  # has_many :lessons, through: :lesson_explanations

  serialize :tags

  after_initialize :set_defaults, :if => :new_record?
  def set_defaults
    self.refnum ||= "Ex-"+SecureRandom.hex(n=3)
  end

end
