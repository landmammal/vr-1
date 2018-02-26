class Course < ApplicationRecord
  belongs_to :instructor, optional: true, class_name: 'User'

  # delete all registrations to this course
  has_many :course_registrations, dependent: :destroy
  has_many :users, through: :course_registrations

  has_many :course_topics, dependent: :destroy
  has_many :topics, through: :course_topics

  # delete all registrations to this course
  has_many :group_registrations, dependent: :destroy
  has_many :groups, through: :group_registrations

  has_many :rehearsals, dependent: :destroy

  after_initialize :set_defaults, :if => :new_record?

  validates :access_code, uniqueness: true

  mount_uploader :cover, CoverUploader
  
  def set_defaults
    self.access_code ||= "CA-"+SecureRandom.hex(n=3)
    # self.refnum ||= "Co-"+SecureRandom.hex(n=3)
    self.privacy ||= "2"
    self.cstatus ||= "0"
  end

  def adminprivacy
    [["Public", 0], ["Public (with access code)", 1],["Paid", 2],["Private (invite only)", 3]]
  end

  def privacy!
    [["Private (invite only)", 3],["Paid", 2]]
  end

  def cstatus!
    [[:Draft, 0],[:Published, 1]]
  end

  def delete_associations
    @lessons = []
    # grab all lessons inside this course and delee them
    self.topics.each { |t| @lessons << Lesson.where(instructor_id: self.instructor, topic_id: t) }
  end

  def topics_ready
    self.topics_order.collect {|r| Topic.find_by_refnum(r) }.compact.map{ |t| t if (t.privacy == 1 && t.approval_status == 1) }.compact
  end

  def has_rehearsals?
    self.rehearsals.size > 0
  end

  def submitted_rehearsals
    self.rehearsals.where(submission: true)
  end
  def has_submitted_rehearsals?
    self.submitted_rehearsals.size > 0
  end


  def draft?
    self.cstatus == 0
  end

  def free?
		self.privacy == 0 && !self.draft?
	end

	def with_code?
		self.privacy == 1 && !self.draft?
	end

	def paid?
		self.privacy == 2 && !self.draft?
  end
  
  def show_price
    "$"+(sprintf "%.2f", (self.price.to_f/100))
  end

	def private?
		self.privacy == 3 && !self.draft?
  end

  def privacy_icon
    if self.free?
      ['ion-earth', 'free course']
    elsif self.with_code?
      ['ion-lock-combination', 'access code required']
    elsif self.paid?
      ['ion-social-usd', 'paid course']
    elsif self.private?
      ['ion-locked', 'private course']
    elsif self.draft?
      ['ion-mouse', 'draft mode']
    end
  end
  
  def owner(user)
    self.instructor == user || user.role == 'admin'
  end

end