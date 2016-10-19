class Feedback < ActiveRecord::Base
  belongs_to :user

  serialize :concept_review

  has_many :performance_feedbacks
  has_many :rehearsals, through: :performance_feedbacks
end
