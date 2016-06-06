class Lesson < ActiveRecord::Base
  belongs_to :course
  belongs_to :chapter
  belongs_to :user
  has_many :practices
end
