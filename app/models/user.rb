class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  has_attached_file :profile, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  has_attached_file :banner, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :profile, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  validates :age, presence: true

  def photo
      profile_file_name.present? ? profile.url(:square) : '/assets/default_user.png'
  end
  def top_banner
      banner_file_name.present? ? banner.url(:medium) : '/assets/banner.jpg'
  end

  enum role: [:admin, :instructor, :coach, :trainee ]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :trainee
  end

  has_many :course_registrations
  has_many :registered_courses, :through => :course_registrations, :foreign_key => :course_id
  
  has_many :courses, foreign_key: :instructor_id
  has_many :lessons, foreign_key: :instructor_id
  has_many :topics, foreign_key: :instructor_id

  has_many :tasks
  has_many :prompts
  has_many :models
  has_many :explanations
  has_many :concepts

  has_many :practices
end
