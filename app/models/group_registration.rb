class GroupRegistration < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :group, optional: true
end
