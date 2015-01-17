class ChargesController < ApplicationController
	layout 'dashboard'
	before_action :authenticated
	before_action :check_token, :only => [:index]

	def index
		@money = Synthesize.find_by_tokener(params[:token]).money
	end

	def create
	  # Amount in cents
	  binding.pry
	  @amount = Synthesize.find_by_tokener(params[:tokener]).money * 100
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

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end

	private
		def check_token
			redirect_to dashboard_index_path if Synthesize.find_by_tokener(params[:token]).nil?
		end
end
