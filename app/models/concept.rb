class Concept < ActiveRecord::Base
  has_many :lesson_concepts
  has_many :lessons, through: :lesson_concepts
end
