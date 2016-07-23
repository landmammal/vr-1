class Rehearsal < ActiveRecord::Base
  belongs_to :course
  belongs_to :progress
  belongs_to :group
end
