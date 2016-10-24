class User < ActiveRecord::Base
  after_create :send_admin_mail, :send_user_notice
  after_update :send_approved_email, :if => :approved_changed?
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

  # validations
  validates_attachment_content_type :profile, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :banner, :content_type => /\Aimage\/.*\Z/
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true
  validates :username, presence: true
  validates_uniqueness_of :username

  # checking for approved in user field
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # we are not using this mssg
    end
  end

  # sends admin and email for everyuser waiting for approval
  def send_admin_mail
   AdminMailer.new_user_waiting_for_approval.deliver_now!
  end

  # sends the user and email when they register for the site
  def send_user_notice
    AdminMailer.user_register_notice(self).deliver_later!
  end

  # send the user and email once there able to access the website
  def send_approved_email
    AdminMailer.user_approved_notice(self).deliver_now!
  end

  # setting the default user avatar and banner if the user hasnt set it
  def photo
      profile_file_name.present? ? profile.url(:square) : '/assets/default_user.png'
  end

  def top_banner
      banner_file_name.present? ? banner.url(:medium) : '/assets/banner.jpg'
  end

  # user roles
  enum role: [:admin, :instructor, :coach, :trainee]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= 3
  end

  @@r = roles.keys
  def level_1
    self.role == @@r[0]
  end
  def level_2
    [@@r[0], @@r[1]].include? self.role
  end
  def level_3
    [@@r[0], @@r[1], @@r[2]].include? self.role
  end
  def level_4
    [@@r[0], @@r[1], @@r[2], @@r[3]].include? self.role
  end

  # associations
  has_many :course_registrations
  has_many :registered_courses, through: :course_registrations, source: :course

  has_many :user_groups
  has_many :register_groups, through: :user_groups, source: :group

  has_many :courses, foreign_key: :instructor_id
  has_many :lessons, foreign_key: :instructor_id
  has_many :topics, foreign_key: :instructor_id
  has_many :groups, foreign_key: :instructor_id

  has_many :tasks
  has_many :prompts
  has_many :models
  has_many :explanations
  has_many :feedbacks
  has_many :concepts
  has_many :rehearsals, foreign_key: :trainee_id

  serialize :terms_of_use
end