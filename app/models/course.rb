class Course < ActiveRecord::Base
  belongs_to :user
  has_many :chapters
  has_many :lessons, :through => :chapters
end
