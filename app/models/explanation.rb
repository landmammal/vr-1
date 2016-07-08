class Explanation < ActiveRecord::Base
  has_many :lesson_explanations
  has_many :lessons, :through => :lesson_explanations 

  serialize :tags
end
