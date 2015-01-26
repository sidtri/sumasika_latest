class DashboardController < ApplicationController
before_action :authenticated 
  def index
    @temporary = 1 	
    @user=my_session
    countryinfo=Country.new(@user['country'])
    @symbol=countryinfo.currency['symbol']
    @currency=countryinfo.currency['code'].downcase 

    # binding.pry
  end

  def ghana
    render :json => User.all
  end

  def create
    binding.pry
  	@synthesize = Synthesize.new(params_permit)
  	@synthesize.user_id = session[:user_id]
  	@synthesize.tokener = SecureRandom.urlsafe_base64 
    @synthesize.status = 'pending'
  	if @synthesize.save
  		redirect_to :controller => :charges, :action => :checkdetails, :token => @synthesize.tokener
  	else
  		render :text => 'Something went wrong'
  	end
  end

  def transactions
    # binding.pry
    @user=my_session
    @details = my_session.synthesizes
  end	

  def verifications

  end

  def logs
    
  end
   
  def settings
     @user=my_session
    @settingdetails = my_session

  end

  ################## Settings for update####################
  def details_update
    
    @save=my_session.update(:first_name => params[:first_name],:last_name =>params[:last_name],:dob => params[:dob],:email => params[:email],:country => params[:user][:country],:address => params[:address],:postalcode => params[:postalcode])

    

    if @save

      redirect_to  dashboard_settings_path , :flash => { :error => "Your Account is Updated sucessfully" }  

    else

      redirect_to  dashboard_settings_path , :flash => { :error => "Your Account is Updated  Failed" }  

    end
    
    
  end
  ################################### view password ######################
  def changepwd
      @user=my_session

  end

  def updatepwd
      @user=my_session
     if BCrypt::Password.new(User.find_by_token(params[:token]).password ) == params['oldpwd']
        if params['newpwd'] == params['confpwd']

            user=User.find_by_token(params[:token])
            user.password=params['newpwd']
            if user.save

              redirect_to dashboard_settings_path , :flash => { :notice => "Your password has been changed sucessfully " }

            end
          else
             redirect_to dashboard_changepwd_path , :flash => { :error => "Your new and old passwords are doesnot match."}
          
        end
      else
        redirect_to dashboard_changepwd_path , :flash => { :error => "Please check old password once"}

     end
     
     
  end
  ################## token expired for checkdetails cancel####################
  def expired

    @status=Synthesize.find_by_tokener(params[:token]).update(:status => 'expired')
    if @status
      redirect_to dashboard_index_path
    else
      redirect_to charges_checkdetails_path,  :token => params[:token]
    end


  end
  private
  	def params_permit
  		params.permit(:mtn, :money, :first_name, :last_name)
  	end
end
