class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  	def my_customer
  		Stripe::Customer.retrieve(User.find(session[:user_id]).account.mask) unless session[:user_id].nil?
  	end
  	def my_session
      session[:user_id].nil? ? nil : User.find(session[:user_id]) 
    end
    def authenticated
      redirect_to sessions_new_path if session[:user_id].nil? 
    end
    
    def checkadmin 
      redirect_to dashboard_index_path unless my_session.role == 1
    end
end
