class Group < ActiveRecord::Base
  belongs_to :instructor, class 'user'

  has_many :user_groups
  has_many :users, through: :user_groups

  has_many :group_registrations
  has_many :courses, through: :group_registrations

end
