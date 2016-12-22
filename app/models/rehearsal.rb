class Rehearsal < ApplicationRecord
  belongs_to :trainee, optional: true, class_name: 'User'

  belongs_to :course, optional: true
  belongs_to :topic, optional: true
  belongs_to :lesson, optional: true
  belongs_to :group, optional: true

  has_many :lesson_rehearsals, dependent: :destroy
  has_many :lessons, through: :lesson_rehearsals

  has_many :performance_feedbacks
  has_many :feedbacks, through: :performance_feedbacks
end
