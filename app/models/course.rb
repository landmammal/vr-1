class Course < ApplicationRecord
  mount_uploader :cover, CoverUploader

  belongs_to :instructor, optional: true, class_name: 'User'

  # delete all registrations to this course
  has_many :course_registrations, dependent: :destroy
  has_many :users, through: :course_registrations

  # has_many :course_topics, dependent: :destroy
  has_many :topics, dependent: :destroy

  # delete all registrations to this course
  has_many :group_registrations, dependent: :destroy
  has_many :groups, through: :group_registrations

  has_many :rehearsals, dependent: :destroy
  validates :access_code, uniqueness: true

  after_initialize :set_defaults, :if => :new_record?
  after_create :set_create_defs
  after_update :set_updates
  
  def set_defaults
    self.access_code ||= "CA-"+SecureRandom.hex(n=3)
    self.refnum ||= "Co-"+SecureRandom.hex(n=3)
    self.title ||= "Unnamed Course"
    self.privacy ||= "3"
    self.cstatus ||= "0"
  end

  def set_updates
    self.title ||= "Unnamed Course"
  end

  def set_create_defs
    self.topics.build( instructor_id: self.instructor_id )
    self.save
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

  def get_tags
    self.tags ? self.tags.split(',') : ['no tags']
  end

  def related
    related = []
    self.get_tags.each do |tag|
      
      Course.all.where.not( id: self.id ).each do |c| 
        next if ( related.include?( c ) )

        if c.get_tags.include?(tag)
          related << c
          next
        end
      end

    end
    related
  end

  def image
    self.cover.url ? self.cover.url.gsub('amp;', '') : '/assets/default_cover.png'
  end

  def has_rehearsals?
    self.rehearsals.size > 0
  end

  def submitted_rehearsals
    self.rehearsals.where(submission: true)
  end

  def pending_rehearsals
    has_pending = false
    self.rehearsals.where(submission: true).each do |r|
      if r.feedbacks.size < 1
        has_pending = true
        break
      end
    end
    has_pending
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
    (sprintf "%.2f", (self.price.to_f/100))
  end

  def private?
    self.privacy == 3 && !self.draft?
  end

  def privacy_icon
    if self.free?
      result = ['ion-earth', 'free course']
    elsif self.with_code?
      result = ['ion-lock-combination', 'access code required']
    elsif self.paid?
      result = ['ion-social-usd', 'paid course']
    elsif self.private?
      result = ['ion-locked', 'private course']
    elsif self.draft?
      result = ['ion-mouse', 'draft mode']
    end
    result
  end
  
  def owner(user)
    self.instructor == user || user.role == 'admin'
  end

end
