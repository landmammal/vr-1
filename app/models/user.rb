class User < ActiveRecord::Base

  enum role: [:user, :trainee, :author, :coach, :manager, :admin]
  after_initialize :set_default_role, if => :new_record?
  #  persisted? instead of new_record?

  def set_default_role
    Self.role ||= :user
  end

  end
  has_many :courses
  has_many :chapters, :through => :courses
  has_many :lessons, :through => :chapters
  has_many :practices
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
end
