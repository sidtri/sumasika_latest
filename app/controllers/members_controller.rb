class MembersController < ApplicationController

  def index

  end

  def new
  	
  end

  def create
   # validate_captcha
   @user = User.new(req_params)
   @user.country = params[:user][:country]
   @user.password = params[:password]
   if @user.save
    @stripe_account = generate_customer
    Account.create(:user_id => @user.id, :mask => @stripe_account.id)
    # Fresher.new_verification()  --- mail needs to send to user
   	redirect_to root_url
   else
   	render :text => "something went wrong"
   end
  end

  
  private
  	def req_params
  		params.permit(:email, :first_name, :last_name, :user, :dob, :address)
  	end
    def generate_customer
      Stripe::Customer.create(:email => req_params[:email])
    end
    def validate_captcha
      target = URI.parse('https://www.google.com/recaptcha/api/siteverify')
      help = {:secret => "6LfVSwATAAAAADeCFWoB3bwuiMXjIfhnOgqV2t37", :response => params['g-recaptcha-response'], :remoteip => '127.0.0.1'}
      target.query = URI.encode_www_form(help)
      captcha_valid = Net::HTTP.get(target)
    end
end
