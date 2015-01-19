class DashboardController < ApplicationController
before_action :authenticated 
  def index
  	
  end

  def ghana
    render :json => User.all
  end

  def create
  	@synthesize = Synthesize.new(params_permit)
  	@synthesize.user_id = session[:user_id]
  	@synthesize.tokener = SecureRandom.urlsafe_base64 
    @synthesize.status = 'pending'
  	if @synthesize.save
  		redirect_to :controller => :charges, :action => :index, :token => @synthesize.tokener
  	else
  		render :text => 'Something went wrong'
  	end
  end

  def transactions
    # binding.pry
    @details = my_session.synthesizes
  end	
   
  def settings
    @settingdetails = my_session
  end

  def email_update
    binding.pry
    my_session.update()
  end
  def details_update
    # binding.pry
    my_session.update(:first_name => params[:first_name],:last_name =>params[:last_name],:dob => params[:dob],:address => params[:address],:postalcode => params[:postalcode])
  end
  private
  	def params_permit
  		params.permit(:mtn, :money, :first_name, :last_name)
  	end
end
