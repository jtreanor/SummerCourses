class MessageMailer < ActionMailer::Base
  default from: "ask@summercourses.mailgun.org"

  def reply_email(message)
    @message = message
    mail(:to => message.user_email, :subject => "Welcome to My Awesome Site")
  end
end
