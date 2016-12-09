class Course < ApplicationRecord
  belongs_to :instructor, optional: true, class_name: 'User'

  has_many :course_registrations
  has_many :users, through: :course_registrations

  has_many :course_topics
  has_many :topics, through: :course_topics

  has_many :group_registrations
  has_many :groups, through: :group_registrations

  has_many :rehearsals

  def privacy!
  	[[:Public, 0],[:Unpublished, 1],[:Paid, 2],[:Private, 3]]
  end

end