class Explanation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :lesson, optional: true

  has_many :lesson_explanations
  has_many :lessons, through: :lesson_explanations

  serialize :tags
end
