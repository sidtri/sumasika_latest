class Reguser < ApplicationMailer
	def sendemail(user)
    @user = user
    mail(to: @user.email, subject: 'Your Registration Is Completed')
  end
end
