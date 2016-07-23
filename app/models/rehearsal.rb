class Rehearsal < ActiveRecord::Base
  belongs_to :course
  belongs_to :progress
  belongs_to :group

  has_many :lesson_rehearsals
  has_many :lessons, through: :lesson_rehearsls
end
