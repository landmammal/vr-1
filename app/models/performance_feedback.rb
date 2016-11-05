class PerformanceFeedback < ApplicationRecord
  belongs_to :rehearsal, optional: true
  belongs_to :feedback, optional: true
end
