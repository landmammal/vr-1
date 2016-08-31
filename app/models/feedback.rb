class Feedback < ActiveRecord::Base
  belongs_to :instructor, class_name: 'User'
  belongs_to :coach, class_name: 'User'

  has_many :performance_feedbacks
  has_many :rehearsals, through: :performance_feedbacks
end
