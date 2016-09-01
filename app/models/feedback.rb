class Feedback < ActiveRecord::Base
  belongs_to :user

  has_many :performance_feedbacks
  has_many :rehearsals, through: :performance_feedbacks
end
