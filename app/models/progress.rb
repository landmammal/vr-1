class Progress < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user
  belongs_to :explanation
  belongs_to :prompt
  belongs_to :model
end
