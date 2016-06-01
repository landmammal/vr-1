class Lesson < ActiveRecord::Base
  belongs_to :course
  belongs_to :chapter
end
