class PerformanceFeedback < ActiveRecord::Base
  belongs_to :rehearsal
  belongs_to :feedback
end
