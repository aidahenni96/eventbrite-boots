class EventMailer < ApplicationMailer
  default from: 'no-reply@yourdomain.com'

  def participation_email(event, user)
    @event = event
    @user = user
    mail(to: @event.admin.email, subject: 'New Participant for Your Event')
  end
end