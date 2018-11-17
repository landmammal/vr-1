class WelcomeController < ApplicationController

  before_action :authenticate_user! , only: [:interface_test, :versions, :reviewtermandservices]
  before_action :check_login , only: [:index]

  #======================== MAIN MENU ========================#

  def index
    @courses = Course.all.select(:id, :title, :tags).to_json
    @demo = Demo.new
  end

  def contact
    @site_title = 'Contact us'
    @demo = Demo.new
  end

  def markets
    @site_title = 'Markets'
  end

  def overview
    @site_title = 'What we offer'
  end

  def test
    # @site_title = 'TESTBOX'
    # topics = Topic.all
    # lessons = Lesson.all
    # explanations = Explanation.all

    # @topics_to_fix = []
    # @lessons_to_fix = []
    # @explanations_to_fix = []

    # topics.each do |topic|
    #   course_topic = CourseTopic.find(topic.id)
    #   topic.course_id = course_topic.course_id if course_topic.course_id != topic.course_id
    #   topic.save
    #   @topics_to_fix << topic if course_topic.course_id != topic.course_id
    # end


    # lessons.each do |lesson|
    #   topic_lesson = TopicLesson.find(lesson.id)
    #   lesson.topic_id = topic_lesson.topic_id if topic_lesson.topic_id != lesson.topic_id
    #   lesson.save
    #   @lessons_to_fix << lesson if topic_lesson.topic_id != lesson.topic_id
    # end


    # explanations.each do |explanation|
    #   lesson_explanation = LessonExplanation.find(explanation.id)
    #   explanation.lesson_id = lesson_explanation.lesson_id if lesson_explanation.lesson_id != explanation.lesson_id
    #   explanation.save
    #   @explanations_to_fix << explanation if lesson_explanation.lesson_id != explanation.lesson_id
    # end


  end






  def reset
    @users = User.all.select(:id, :first_name, :last_name, :username, :role, :age, :race, :gender, :email, :approved, :terms_of_use)
    # render json: @users.to_json
  end



  def job_application
    app = {
      "first_name" => params[:first_name],
      "last_name" => params[:last_name],
      "email" => params[:email],
      "phone" => params[:phone],
      "job" => params[:job],
      "resume" => params[:resume],
      "website" => params[:website],
      "about" => params[:about],
      "references" => params[:references]
    }
    @error = false

    if app['resume'].empty?
      @error = true
      @error_text = "We need a link to your resume or portfolio."
    end 

    if app['email'].empty? || app['phone'].empty?
      @error = true
      @error_text = "Email and Phone # need to be filled out"
    end

    if app['first_name'].empty? || app['last_name'].empty?
      @error = true
      @error_text = "First name and last name need to be filled out"
    end

    AdminMailer.send_job_application( app ).deliver_later if !@error

    respond_to do |format|
      format.js { }
    end

  end



  def interface_test
    @site_title = 'TESTBOX :: Interface'
  	render "interface"
  end

  def accepttermandservices
    require 'socket'
    ip=Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
    ip ? thisIp = ip.ip_address : thisIp = 'noIp'

    current_user.update_attribute(:terms_of_use, { user_ip:thisIp, date:Time.now, version:'V1Aug192016' })

    render json: current_user.terms_of_use
  end


  #========================== FOOTER =========================#

  #Footer 1 ====
  def about
    @site_title = 'About videoRehearser'
  end

  def press
    @site_title = 'Press and Kit'
  end

  def termsandservices
    @site_title = 'Terms and Services'
  end

  def policies
    @site_title = 'Privacy Policies'
  end


  #Footer 2 ====
  def support
    @site_title = 'Technical Support'
  end

  def requirements
    @site_title = 'System Requirements'
  end

  def faqs
    @site_title = 'Frequently Asksed Questions'

    @faqs = [
      ['What is videoRehearser (vR)?', 'videoRehearser (vR) is a virtual training platform engineered by educators to expedite social, academic, and workplace learning. '],
      ['How does it work? ', 'vR is uniquely positioned to empower learners in an unprecedented way because it fosters authentic changes through natural learning principles and processes.'],
      ['Who uses vR?', 'vR expedites learning and helps companies scale their training. '],
      ['Why was it created?', 'Traditional e-Learning systems have been overpromising, but underperforming. We believe in evolutionizing the current blended learning format and introducing engineered training that works.'],
      ['What do I need to use videoRehearser?', 'A computer, tablet or mobile device equipped with a webcam.'],
      ['Who do I contact for more information?', 'If you are interested in learning more or setting up a demo, contact demo@videorehearser.com']
    ]
  end



  #Footer 3 ====
  def team
    @site_title = 'Who we are'
  end

  
  
  
  def education
    @site_title = 'vR for Education'
  end

  def business
    @site_title = 'vR for Business'
  end

  def workforce
    @site_title = 'vR for Workforce'
  end

  def wellness
    @site_title = 'vR for Wellness'
  end

  
  
  
  def teach
    @site_title = 'Teach with us'
  end

  def price
    @site_title = 'Pricing'
    faqs
  end

  def coach
    @site_title = 'Coach students'
  end

  def create
    @site_title = 'Create Visual Content'
  end

  def companies
    @site_title = 'Companies'
  end

  def versions
    @site_title = 'Version Documentation'
  end



  private

  def check_login
    redirect_to '/users/'+current_user.id.to_s if current_user
  end

end
