class TestMailer < ApplicationMailer
default from: 'infosumasika@gmail.com'
	 
  def welcome_email(user)
  	@user = user
  	@url  = 'http://example.com/login'
    mail(to: 'koolspy.siddhu@gmail.com', subject: 'Welcome to My Awesome Site')
  end
end
