class Model < ActiveRecord::Base
  has_many :lesson_models
  has_many :lessons, through: :lesson_models

  serialize :tags
end
