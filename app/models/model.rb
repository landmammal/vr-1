class Model < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  
  has_many :lesson_models
  has_many :lessons, through: :lesson_models

  serialize :tags
end
