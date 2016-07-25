class Rehearsal < ActiveRecord::Base
  belongs_to :user

  belongs_to :course
  belongs_to :progress
  belongs_to :group

  has_many :lesson_rehearsals
  has_many :lessons, through: :lesson_rehearsals
end
