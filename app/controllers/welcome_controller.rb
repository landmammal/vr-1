class WelcomeController < ApplicationController

  before_action :authenticate_user! , only: [:interface_test]
  before_action :check_login , only: [:index]

  #======================== MAIN MENU ========================#

  def index
    @courses = Course.all.select(:id, :title, :tags).to_json
  end

  def contact
    @site_title = 'Contact us'
  end

  def markets
    @site_title = 'Markets'
  end

  def product
    @site_title = 'What we offer'
  end

  def test
    @site_title = 'TESTBOX'
  end

  def interface_test
    @site_title = 'TESTBOX :: Interface'
  	render "interface"
  end



  #========================== FOOTER =========================#

  #Footer 1 ====
  def about
    @site_title = 'About Video Rehearser'
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

  def FAQs
    @site_title = 'Frequently Asksed Questions'
  end


  #Footer 3 ====
  def theteam
    @site_title = 'Who we are'
  end

  def learn
    @site_title = 'Learn with us'
  end

  def teach
    @site_title = 'Teach with us'
  end

  def coach
    @site_title = 'Coach students'
  end

  def create
    @site_title = 'Create Visual Content'
  end



  private

  def check_login
    redirect_to '/users/'+current_user.id.to_s if current_user
  end

end
