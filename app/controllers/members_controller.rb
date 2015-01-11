class MembersController < ApplicationController
layout 'cras'
  def index

  end

  def new
  	
  end

  def create
    binding.pry
   @user = User.new(req_params)
   @user.password = params[:password]
   if @user.save
   	redirect_to root_url
   else
   	render :text => "something went wrong"
   end
  end

  
  private
  	def req_params
  		params.permit(:email, :first_name, :last_name, :country, :dob, :address)
  	end
end
