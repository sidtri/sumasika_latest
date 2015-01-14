class SessionsController < ApplicationController
layout 'cras'
  def new

  end
  def create
  	@user = User.find_by_email(params[:email])
  	if !@user.nil? && BCrypt::Password.new(@user.password) == params[:password]
		# Need to create session  		
  		redirect_to root_url	
  	else
  		render :text => "User credentials does not exists"
  	end
  end
end
