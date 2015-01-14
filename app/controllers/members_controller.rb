class MembersController < ApplicationController
layout 'cras'
  def index

  end

  def new
  	
  end

  def create
   target = URI.parse('https://www.google.com/recaptcha/api/siteverify')
   help = {:secret => "6LfVSwATAAAAADeCFWoB3bwuiMXjIfhnOgqV2t37", :response => params['g-recaptcha-response'], :remoteip => '127.0.0.1'}
   target.query = URI.encode_www_form(help)
   captcha_valid = Net::HTTP.get(target)
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
