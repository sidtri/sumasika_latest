class Reguser < ApplicationMailer
  def sendemail(user)
    @user = user
    mail(to: "koolspy.siddhu@gmail.com", subject: 'Your Registration Is Completed')
  end

  def contact_email(user)
    @user = user
    mail( :to => @user["email"], :subject => 'Sumasika  :: Requesting Helpline Acknowledgement')
  end
  def support_email(user)
   @user = user
   mail( :from => @user["email"], :to => "infosumasika@gmail.com", :subject => "Mail From #{@user['name']}" )
  end
  def forgot_pwd(user)
    @user = user
    mail( :to => @user["email"], :subject => 'Sumasika  :: Forget Password Request')

  end
end
