class MessageMailer < ActionMailer::Base
  default from: "ask@summercourses.mailgun.org"

  def reply_email(message)
    @message = message

    #Get most recent question in the thread.
    @recent_message = @message.message_thread.messages.find_all{|m| !m.is_response }.sort_by{|m| -m[:created_at]}[0]

    mail(:to => message.message_thread.user_email, :subject => "Re: #{message.message_thread.subject} - #{message.message_thread.id}")
    logger.info "Sent email with subject #{"#{message.message_thread.subject} - #{message.message_thread.id}"} to #{message.message_thread.user_email}"
  end
end
