class DashboardController < ApplicationController
before_action :authenticated 
  def index
    @temporary = 1 	
    @user=my_session
    countryinfo=Country.new(@user['country'])
    @symbol=countryinfo.currency['symbol']
    @currency=countryinfo.currency['code'].downcase 
    @dashboard = 'active'
  end

  def ghana
    render :json => User.all
  end

  def create
    @synthesize = Synthesize.new(params_permit)
    @synthesize.rate = 5.0 # need to change later
    @synthesize.code = params_permit['currency']
    @synthesize.user_id = session[:user_id]
  	@synthesize.tokener = SecureRandom.urlsafe_base64 
    @synthesize.status = 'pending'
    unless params_permit[:apply_charges] == "true"
      @synthesize.money = @synthesize.money * (100 + @synthesize.rate) * 0.01
    end
    if @synthesize.save
  		redirect_to :controller => :charges, :action => :checkdetails, :token => @synthesize.tokener
  	else
  		render :text => 'Something went wrong'
  	end
  end

  def transactions
    @user=my_session
    @details = my_session.synthesizes.includes(:event)
    @transactions = 'active'
  end	

  def transactions_brief
    @info = Stripe::Charge.retrieve(params[:charge_id])
    @card = @info.card
    @user = my_session
  end

  def verifications

  end

  def logs
    
  end
   
  def settings
     @userform= User.new()
     @user=my_session
     @settingdetails = my_session
  end

  ################## Settings for update####################
  def details_update
    @save=my_session.update(:first_name => params[:first_name],:last_name =>params[:last_name],:dob => params[:dob],:email => params[:email],:country => params[:user][:country],:address => params[:address],:postalcode => params[:postalcode])
    if @save
      my_session.update(:image => params[:user][:image]) unless params[:user][:image].nil?
      redirect_to  dashboard_settings_path , :flash => { :notice => "Your Account is Updated sucessfully" }  
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
             redirect_to dashboard_changepwd_path , :token => params[:token] , :flash => { :error => "Your new and old passwords are doesnot match."}
        end
      else
        redirect_to dashboard_changepwd_path(:token => params[:token]) ,:flash => { :error => "Please check old password once"}
     end
     
     
  end
  ################## token expired for checkdetails cancel####################
  def expired

    @status=Synthesize.find_by_tokener(params[:token]).update(:status => 'pending')
    if @status
      redirect_to dashboard_index_path
    else
      redirect_to charges_checkdetails_path,  :token => params[:token]
    end


  end
  private
  	def params_permit
      params.require(:user).permit(:currency,:apply_charges, :money,:first_name,:last_name,:mtn)
  	end
end
