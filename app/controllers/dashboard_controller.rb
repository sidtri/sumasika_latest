class DashboardController < ApplicationController
before_action :authenticated 
  def index
  	
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
    binding.pry
  end

  private
  	def params_permit
  		params.permit(:mtn, :money, :first_name, :last_name)
  	end
end
