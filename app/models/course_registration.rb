class CourseRegistration < ApplicationRecorde
  belongs_to :user, optional: true
  belongs_to :course, optional: true
end
