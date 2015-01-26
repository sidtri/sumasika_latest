class ChargesController < ApplicationController
	layout 'dashboard'
	before_action :authenticated
	before_action :check_token, :only => [:index]
    before_action :check_stripe_token, :only => [:create]

	def index
		s = Synthesize.find_by_tokener(params[:token]).reload
		@user = my_session
		if s.status == 'pending'
			@money = s.money
		else
			render :text => "Your token expired please do recharge with new token"
		end
	end

	def create
	  # Amount in cents
	  @user = my_session
	  synthesize = Synthesize.find_by_tokener(params[:tokener])
	  @amount = synthesize.money * 100
	  customer = my_customer
	  customer.description = "Testing description need to update"
	  customer.card = params[:stripeToken] # obtained with Stripe.js
	  if customer.save
		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount.to_i,
		    :description => 'Rails Stripe customer',
		    :receipt_email => customer.email,
		    :currency    => 'usd'
		  )
		  Event.create(:customer_id => customer.id, :event_id => charge.id, :synthesize_id => synthesize.id )
		  synthesize.status = "charged"
		  synthesize.save
	   else
	   	synthesize.status = "expired"
	   	redirect_to dashboard_index_path, :error => "Something went wrong - Maybe wrong credentials"
	   end

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to :controller => 'charges', :action => 'index', :token => params[:tokener]
	end

	
	def show
		@user=my_session
		@paymentdetails=Synthesize.find_by_tokener(params[:token])
	end

	private
		def check_token
			redirect_to dashboard_index_path if Synthesize.find_by_tokener(params[:token]).nil?
		end
		def check_stripe_token
		  if params[:stripeToken].nil?
			flash[:error] = "May be wrong credentials or you've submitted before page fully loaded"
			redirect_to :controller => 'charges', :action => 'index', :token => params[:tokener]
		  end
		end
end
