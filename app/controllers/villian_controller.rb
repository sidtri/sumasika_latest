class VillianController < ApplicationController
  def user_destroy
	session[:user_id] = nil
  	redirect_to root_url
  end

  def admin_destroy
   session[:manager_id] = nil
   redirect_to admin_sessions_new_path
  end
end
