class MembersController < ApplicationController

  def index

  end

  def new
  	
  end

  def admin

  end

  def create
   # validate_captcha
   @user = User.new(req_params)
   @user.country = params[:user][:country]
   @user.password = params[:password]
   @user.token = SecureRandom.urlsafe_base64 
   if @user.save
    @stripe_account = generate_customer
    Account.create(:user_id => @user.id, :mask => @stripe_account.id)
    Reguser.sendemail(@user).deliver_now
    # Fresher.new_verification()  --- mail needs to send to user
   	redirect_to sessions_new_path , :flash => { :notice => "Your signup is sucessfully and now before do login verify your email " }
   else
   	redirect_to members_new_path , :flash => { :error => "Please check your credentials" }
   end
  end

  def verifyemail
    unless  params[:token].nil?
      @active=User.find_by_token(params[:token]).update(:active => 1)
      if @active
      redirect_to sessions_new_path , :flash => { :notice => "Your email is sucessfuly activated please login here" }
      end
    end
  end

  def creators
    @manager = Manager.new(req_params)
    @manager.country = params[:user][:country]
    @manager.password = params[:password]
    @manager.active = false
    if @manager.save
      redirect_to admin_members_new_path, :notice => "Completed, Admin needs to verify your account"
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
