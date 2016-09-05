class WelcomeController < ApplicationController

  def index
        @courses = Course.all.select(:id, :title, :tags).to_json
  end

  def about

  end

  def contact
    @new_contact = Contact.new
  end

  def theprocess

  end

  def markets

  end

  def product

  end

  def test

  end

  def interface_test
  		render "interface"
  end



  # FOOTER

  def theteam

  end

  def termsandservices

  end
  def FAQs

  end
  def requirements

  end

end
