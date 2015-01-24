class ChargesController < ApplicationController
	layout 'dashboard'
	before_action :authenticated
	before_action :check_token, :only => [:index]

	def index
		s = Synthesize.find_by_tokener(params[:token]).reload
		if s.status == 'pending'
			@money = s.money
		else
			render :text => "Your token expired please do recharge with new token"
		end
	end

	def create
	  # Amount in cents
	  synthesize = Synthesize.find_by_tokener(params[:tokener])
	  @amount = synthesize.money * 100
	  customer = my_customer
	  customer.description = "Testing description need to update"
	  customer.card = params[:stripeToken] # obtained with Stripe.js
	  customer.save
	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount.to_i,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )
	  synthesize.status = "charged"
	  synthesize.save


	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end

	# def checkdetails

	# end

	def show

		@paymentdetails=Synthesize.find_by_tokener(params[:token])
		

	end

	private
		def check_token
			redirect_to dashboard_index_path if Synthesize.find_by_tokener(params[:token]).nil?
		end
end
