class CrasController < ApplicationController
  def index
    @user = my_session unless my_session.nil?  	
  end

  def howitworks

  end

  def aboutus
  	
  end

  def contactus
	Reguser.contact_email(params).deliver_now
	Reguser.support_email(params).deliver_now
	redirect_to root_url , :alert => "Mail send sucessfully"
  end
end
