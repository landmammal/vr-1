class Feedback < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :coach
  belongs_to :rehearsal
end
