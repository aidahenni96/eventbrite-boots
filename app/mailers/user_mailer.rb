class UserMailer < ApplicationMailer
  default from: 'no-reply@yourdomain.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Eventbrite Clone')
  end
end
