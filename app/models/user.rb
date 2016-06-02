class User < ActiveRecord::Base
  has_many :courses
  has_many :chapters, :through => :courses
  has_many :lessons, :through => :chapters
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
end
