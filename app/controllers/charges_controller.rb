class ChargesController < ApplicationController

  def new

  end

  def create
    # Amount in cents

    # create a stripe customer
    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
    )

    # create a charge by passing the customer
    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => params[:amount],
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
    )

    # create record of purcahses for user
    purchase = Purchase.create(email: params[:stripeEmail], card: params[:stripeToken], amount: params[:amount], description: charge.description,
                               currency: charge.currency,
                               customer_id: customer.id, product_id: params[:productId])

    # if there are no errors from stripe register user to the course he just bought
    cr = CourseRegistration.create(course_id: params[:productId], user_id: current_user.id, approval_status: true, user_role: 3)
    cr.save

    # find course purchase and redirect him to it
    course = Course.find(params[:productId])
    redirect_to course

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end