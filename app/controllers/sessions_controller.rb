class SessionsController < ApplicationController
  def new
    redirect_to dashboard_index_path unless session[:user_id].nil?
  end
  def create
  	@user = User.find_by_email(params[:email])
  	if !@user.nil? && BCrypt::Password.new(@user.password) == params[:password]
		  # need to find alternative to session later on ...
      session[:user_id] = @user.id
  		redirect_to root_url
  	else
  		render :text => "User credentials does not exists"
  	end
  end
  
  def destroy
    session[:user_id] = nil
  end
end
