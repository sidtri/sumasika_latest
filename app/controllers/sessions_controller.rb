class SessionsController < ApplicationController
  before_action :user_dashboard, only: [:new, :create]
  before_action :admin_dashboard, only: [:admin, :creators]
  before_action :migrate_dashboard

  def new
    redirect_to dashboard_index_path unless session[:user_id].nil?
  end
  def create
  	@user = User.find_by_email(params[:email])
  	if !@user.nil? && BCrypt::Password.new(@user.password) == params[:password] && @user.active == 1
		  # need to find alternative to session later on ...
      session[:user_id] = @user.id
  		redirect_to dashboard_index_path, :flash => { :notice => "Welcome to sumasika" }
  	else
  		redirect_to sessions_new_path , :flash => { :error => "User credentials does not exists" }
  	end
  end

  def admin

  end

  def creators
    @manager = Manager.find_by_email(params[:email])
    if !@manager.nil? && BCrypt::Password.new(@manager.password) == params[:password]
      if @manager.active
        session[:manager_id] = @manager.id
        redirect_to admin_path, :notice => "Welcome to sumasika"
      else
        redirect_to admin_sessions_new_path, :notice => "Admin needs to activate your account"
      end
    else
      render :text => "User credentials does not exists"
    end
  end

  ##############################Forgot password###############################################
  def forgetpwd
      
  end

  def resetemail
      a=params.permit(:email)
      @user=User.find_by_email(a['email'])

      unless @user.nil?
           
           Reguser.forgot_pwd(@user).deliver_now 
           redirect_to sessions_forgetpwd_path , :flash => { :notice => 'You can go for reset the password in to email '}
      else
          redirect_to sessions_forgetpwd_path , :flash => { :error => 'You have enterd email is wrong please enter correct email address '}
      end

      
  end

  def updatepwd


  end

  def resetpwd
    if params[:newpwd] == params[:oldpwd]

       user=User.find_by_token(params[:token])
      user.password=params['newpwd']
      if user.save
        redirect_to sessions_new_path , :flash => { :notice => 'your password is changed sucessfully please login here'}
      end


    else
      redirect_to sessions_updatepwd_path(params[:token]) , :flash=>{ :error =>'your new password and old password dose not match'}

    end
  end

  private
    def user_dashboard
      redirect_to dashboard_index_path unless session[:user_id].nil?
    end
    def admin_dashboard
      redirect_to  admin_path unless session[:manager_id].nil?
    end
    def migrate_dashboard
      if !session[:user_id].nil?
        redirect_to dashboard_index_path
      elsif !session[:manager_id].nil?
        redirect_to admin_path
      end
    end
end
