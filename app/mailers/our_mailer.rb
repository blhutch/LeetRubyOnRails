class OurMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://leetapp.herokuapp.com/login'
    mail(to: @user.email, subject: 'Welcome to Leet')
  end
end
