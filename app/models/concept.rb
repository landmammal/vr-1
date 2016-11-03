class Concept < ApplicationRecord
  has_many :lesson_concepts
  has_many :lessons, through: :lesson_concepts

  belongs_to :lesson

  serialize :tags
end
