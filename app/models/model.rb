class Model < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lesson, optional: true
  
  has_many :lesson_models
  has_many :lessons, through: :lesson_models

  serialize :tags
end
