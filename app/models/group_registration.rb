class GroupRegistration < ActiveRecord::Base
  belongs_to :course
  belongs_to :group
end
